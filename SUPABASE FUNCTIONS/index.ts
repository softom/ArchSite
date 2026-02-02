// supabase/functions/timeline/index.ts
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

function withCors(headers: Headers) {
  headers.set("Access-Control-Allow-Origin", "*");
  headers.set("Access-Control-Allow-Methods", "GET,OPTIONS");
  headers.set("Access-Control-Allow-Headers", "content-type,authorization");
  return headers;
}

function json(data: unknown, status = 200, cacheSeconds = 60) {
  const headers = withCors(new Headers());
  headers.set("content-type", "application/json; charset=utf-8");
  headers.set("cache-control", `public, max-age=${cacheSeconds}`);
  return new Response(JSON.stringify(data, null, 2), { status, headers });
}

function badRequest(message: string) {
  return json({ error: message }, 400, 0);
}

type MediaThumb = {
  url: string;
  kind: string | null;
  caption_ru: string | null;
  credit: string | null;
};

function toInt(x: string | null): number | null {
  if (!x) return null;
  const n = Number(x);
  if (!Number.isFinite(n)) return null;
  return Math.trunc(n);
}

function parseStyleIds(url: URL): number[] {
  const one = toInt(url.searchParams.get("style_id"));
  const manyRaw = (url.searchParams.get("style_ids") ?? "").trim();

  const ids = new Set<number>();
  if (one !== null) ids.add(one);

  if (manyRaw) {
    for (const part of manyRaw.split(",")) {
      const n = Number(part.trim());
      if (Number.isFinite(n)) ids.add(Math.trunc(n));
    }
  }

  return Array.from(ids).filter((n) => n > 0);
}

function parseInclude(url: URL): Set<string> {
  const inc = (url.searchParams.get("include") ?? "").trim();
  const out = new Set<string>();
  if (!inc) return out;
  for (const p of inc.split(",")) out.add(p.trim());
  return out;
}

function mediaUrl(SUPABASE_URL: string, m: any): string | null {
  const publicUrl = (m?.public_url as string | null) ?? null;
  if (publicUrl) return publicUrl;

  const bucket = (m?.storage_bucket as string | null) ?? "project-images";
  const path = (m?.storage_path as string | null) ?? null;
  if (!path) return null;

  return `${SUPABASE_URL}/storage/v1/object/public/${bucket}/${path}`;
}

async function loadMediaByIds(
  supabase: any,
  SUPABASE_URL: string,
  ids: number[],
): Promise<Map<number, MediaThumb>> {
  const out = new Map<number, MediaThumb>();
  const uniq = Array.from(new Set(ids)).filter(Boolean);
  if (!uniq.length) return out;

  const { data, error } = await supabase
    .from("media_assets")
    .select("id, storage_bucket, storage_path, public_url, kind, caption_ru, credit, is_published")
    .in("id", uniq)
    .eq("is_published", true);

  if (error) throw new Error(`media_assets: ${error.message}`);

  for (const m of (data ?? []) as any[]) {
    const url = mediaUrl(SUPABASE_URL, m);
    if (!url) continue;
    out.set(m.id, {
      url,
      kind: m.kind ?? null,
      caption_ru: m.caption_ru ?? null,
      credit: m.credit ?? null,
    });
  }
  return out;
}

// select with graceful fallback if some columns do not exist
async function safeSelect(
  supabase: any,
  table: string,
  primaryCols: string,
  fallbackCols: string,
  apply: (q: any) => any,
) {
  const q1 = apply(supabase.from(table).select(primaryCols));
  const r1 = await q1;
  if (!r1.error) return r1;

  const msg = String(r1.error.message || "");
  if (msg.includes("does not exist")) {
    const q2 = apply(supabase.from(table).select(fallbackCols));
    const r2 = await q2;
    return r2;
  }
  return r1;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: withCors(new Headers()) });
  }
  if (req.method !== "GET") {
    return json({ error: "Method not allowed" }, 405, 0);
  }

  try {
    const urlObj = new URL(req.url);

    // If layer not provided -> LEGACY mode (backward compatible)
    const layerRaw = urlObj.searchParams.get("layer");
    const layer = (layerRaw ?? "").trim() || "legacy";
    if (!["legacy", "structure", "quotes", "projects"].includes(layer)) {
      return badRequest("layer must be one of: legacy, structure, quotes, projects");
    }

    const SUPABASE_URL = Deno.env.get("SUPABASE_URL") ?? Deno.env.get("PUBLIC_SUPABASE_URL");
    const SERVICE_ROLE_KEY = Deno.env.get("SERVICE_ROLE_KEY");
    if (!SUPABASE_URL) return json({ error: "Missing env SUPABASE_URL (or PUBLIC_SUPABASE_URL)" }, 500, 0);
    if (!SERVICE_ROLE_KEY) return json({ error: "Missing secret SERVICE_ROLE_KEY" }, 500, 0);

    const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
      auth: { persistSession: false },
    });

    // ---------- STRUCTURE (common for all modes) ----------
    const phSel = await safeSelect(
      supabase,
      "phenomena",
      "id, slug, title_ru, title_en, date_start_year, date_end_year, short_definition, color, sort_order, image_media_id",
      "id, slug, title_ru, title_en, date_start_year, date_end_year, short_definition, color, sort_order",
      (q) => q.eq("is_published", true).order("sort_order", { ascending: true }),
    );
    if (phSel.error) return json({ error: phSel.error.message, where: "phenomena" }, 500, 0);
    const phenomena = phSel.data ?? [];

    const stSel = await safeSelect(
      supabase,
      "styles",
      "id, slug, title_ru, title_en, date_start_year, date_end_year, one_liner, description, color, image_media_id",
      "id, slug, title_ru, title_en, date_start_year, date_end_year, one_liner, description, color",
      (q) => q.eq("is_published", true).order("date_start_year", { ascending: true }),
    );
    if (stSel.error) return json({ error: stSel.error.message, where: "styles" }, 500, 0);
    const styles = stSel.data ?? [];

    const allStyleIds: number[] = styles.map((s: any) => s.id);

    const { data: ps, error: psErr } = await supabase
      .from("phenomenon_style")
      .select("phenomenon_id, style_id, is_primary, sort_order, note")
      .in("style_id", allStyleIds.length ? allStyleIds : [-1]);

    if (psErr) return json({ error: psErr.message, where: "phenomenon_style" }, 500, 0);

    // Optional: attach images for epochs/styles if image_media_id exists
    const phImageIds = (phenomena as any[]).map((p) => p.image_media_id).filter(Boolean);
    const stImageIds = (styles as any[]).map((s) => s.image_media_id).filter(Boolean);

    let mediaById = new Map<number, MediaThumb>();
    try {
      mediaById = await loadMediaByIds(supabase, SUPABASE_URL, [...phImageIds, ...stImageIds]);
    } catch {
      // ignore image load errors (won't break timeline)
    }

    const phenomenaOut = (phenomena as any[]).map((p) => ({
      ...p,
      image: p.image_media_id ? (mediaById.get(p.image_media_id) ?? null) : null,
    }));

    const stylesOutBase = (styles as any[]).map((s) => ({
      ...s,
      image: s.image_media_id ? (mediaById.get(s.image_media_id) ?? null) : null,
    }));

    // ---------- LAYER: structure ----------
    if (layer === "structure") {
      return json(
        {
          version: 11,
          layer: "structure",
          generated_at: new Date().toISOString(),
          phenomena: phenomenaOut,
          styles: stylesOutBase,
          phenomenon_style: ps ?? [],
        },
        200,
        300,
      );
    }

    // For quotes/projects layers need style_id(s)
    const requestedStyleIds = parseStyleIds(urlObj);
    const targetStyleIds = (layer === "legacy")
      ? allStyleIds
      : requestedStyleIds;

    if (layer !== "legacy" && !targetStyleIds.length) {
      return badRequest("For layer=quotes/projects you must provide style_id=... or style_ids=1,2,3");
    }

    // ---------- helper: phenomenon_links per style ----------
    const phenomenonLinksByStyleId = new Map<number, any[]>();
    for (const link of (ps ?? []) as any[]) {
      const list = phenomenonLinksByStyleId.get(link.style_id) ?? [];
      list.push(link);
      phenomenonLinksByStyleId.set(link.style_id, list);
    }

    // ---------- LAYER: quotes ----------
    if (layer === "quotes") {
      const { data: sr, error: srErr } = await supabase
        .from("style_reference")
        .select("style_id, reference_id, relation_type, is_primary, sort_order, note")
        .in("style_id", targetStyleIds);

      if (srErr) return json({ error: srErr.message, where: "style_reference" }, 500, 0);

      const refIds: number[] = Array.from(new Set((sr ?? []).map((x: any) => x.reference_id)));

      let referenceEntries: any[] = [];
      if (refIds.length) {
        const { data: refs, error: refErr } = await supabase
          .from("reference_entries")
          .select("id, slug, kind, subtype, title_original, title_ru, text_original, text_ru, original_language, year, href, reliability, commentary")
          .in("id", refIds)
          .eq("is_published", true);

        if (refErr) return json({ error: refErr.message, where: "reference_entries" }, 500, 0);
        referenceEntries = refs ?? [];
      }

      const refById = new Map<number, any>(referenceEntries.map((r: any) => [r.id, r]));

      // (optional) authors for references
      const { data: ra, error: raErr } = await supabase
        .from("reference_author")
        .select("reference_id, author_id, role")
        .in("reference_id", refIds.length ? refIds : [-1]);

      if (raErr) return json({ error: raErr.message, where: "reference_author" }, 500, 0);

      const authorIds: number[] = Array.from(new Set((ra ?? []).map((x: any) => x.author_id)));

      let authors: any[] = [];
      if (authorIds.length) {
        const { data: au, error: auErr } = await supabase
          .from("authors")
          .select("id, slug, full_name, birth_year, death_year, wiki_url, entity_type")
          .in("id", authorIds)
          .eq("is_published", true);

        if (auErr) return json({ error: auErr.message, where: "authors" }, 500, 0);
        authors = au ?? [];
      }

      const authorById = new Map<number, any>(authors.map((a: any) => [a.id, a]));

      const authorsByRefId = new Map<number, any[]>();
      for (const link of (ra ?? []) as any[]) {
        const a = authorById.get(link.author_id);
        if (!a) continue;
        const list = authorsByRefId.get(link.reference_id) ?? [];
        list.push({ ...a, role: link.role });
        authorsByRefId.set(link.reference_id, list);
      }

      const byStyle = new Map<number, any[]>();
      for (const link of (sr ?? []) as any[]) {
        const r = refById.get(link.reference_id);
        if (!r) continue;
        const list = byStyle.get(link.style_id) ?? [];
        list.push({
          ...r,
          relation_type: link.relation_type,
          is_primary: link.is_primary,
          sort_order: link.sort_order ?? 0,
          note: link.note ?? null,
          authors: authorsByRefId.get(r.id) ?? [],
        });
        byStyle.set(link.style_id, list);
      }

      const stylesOut = targetStyleIds.map((sid) => {
        const rel = (byStyle.get(sid) ?? []).sort((a: any, b: any) => (a.sort_order ?? 0) - (b.sort_order ?? 0));
        const slogans = rel.filter((x: any) => x.relation_type === "slogan");
        const key_text = rel.find((x: any) => x.relation_type === "key_text") ?? null;
        return { style_id: sid, slogans, key_text };
      });

      return json(
        { version: 11, layer: "quotes", generated_at: new Date().toISOString(), styles: stylesOut },
        200,
        120,
      );
    }

    // ---------- LAYER: projects (and legacy includes projects) ----------
    const projectsPerStyle = Number(urlObj.searchParams.get("projectsPerStyle") ?? "8");
    if (!Number.isFinite(projectsPerStyle) || projectsPerStyle < 0 || projectsPerStyle > 50) {
      return badRequest("projectsPerStyle must be a number between 0 and 50");
    }

    async function buildProjectsBlock(styleIds: number[]) {
      const { data: pst, error: pstErr } = await supabase
        .from("project_style")
        .select("project_id, style_id, confidence")
        .in("style_id", styleIds);

      if (pstErr) throw new Error(`project_style: ${pstErr.message}`);

      const projectIds: number[] = Array.from(new Set((pst ?? []).map((x: any) => x.project_id)));

      let projects: any[] = [];
      if (projectIds.length) {
        const { data: pr, error: prErr } = await supabase
          .from("projects")
          .select("id, slug, title_original, title_ru, year_start, year_end, city, country, typology, wiki_url, description_short, project_kind, lat, lon")
          .in("id", projectIds)
          .eq("is_published", true);

        if (prErr) throw new Error(`projects: ${prErr.message}`);
        projects = pr ?? [];
      }

      const projectById = new Map<number, any>(projects.map((p: any) => [p.id, p]));

      // media thumbs 1–2 per project
      const mediaByProjectId = new Map<number, MediaThumb[]>();

      if (projectIds.length) {
        const { data: pmRows, error: pmErr } = await supabase
          .from("project_media")
          .select("project_id, sort_order, is_cover, media_assets(id, storage_bucket, storage_path, public_url, kind, caption_ru, credit, is_published)")
          .in("project_id", projectIds)
          .order("is_cover", { ascending: false })
          .order("sort_order", { ascending: true });

        if (pmErr) throw new Error(`project_media: ${pmErr.message}`);

        for (const row of (pmRows ?? []) as any[]) {
          const m = row.media_assets;
          if (!m) continue;
          if (m.is_published === false) continue;

          const url = mediaUrl(SUPABASE_URL, m);
          if (!url) continue;

          const list = mediaByProjectId.get(row.project_id) ?? [];
          if (list.length >= 2) continue;

          list.push({
            url,
            kind: m.kind ?? null,
            caption_ru: m.caption_ru ?? null,
            credit: m.credit ?? null,
          });
          mediaByProjectId.set(row.project_id, list);
        }
      }

      const projectsByStyleId = new Map<number, any[]>();
      for (const link of (pst ?? []) as any[]) {
        const p = projectById.get(link.project_id);
        if (!p) continue;
        const list = projectsByStyleId.get(link.style_id) ?? [];
        list.push({
          ...p,
          confidence: link.confidence ?? null,
          images: mediaByProjectId.get(p.id) ?? [],
        });
        projectsByStyleId.set(link.style_id, list);
      }

      // slice + sort per style
      const stylesBlock = styleIds.map((sid) => {
        const projs = (projectsByStyleId.get(sid) ?? [])
          .sort((a: any, b: any) => (a.year_start ?? 9999) - (b.year_start ?? 9999))
          .slice(0, projectsPerStyle);
        return { style_id: sid, projects: projs };
      });

      return { pst: pst ?? [], stylesBlock };
    }

    if (layer === "projects") {
      try {
        const { stylesBlock } = await buildProjectsBlock(targetStyleIds);
        return json(
          { version: 11, layer: "projects", generated_at: new Date().toISOString(), styles: stylesBlock },
          200,
          120,
        );
      } catch (e) {
        return json({ error: String(e) }, 500, 0);
      }
    }

    // ---------- LEGACY mode (backward compatible, like old timeline) ----------
    // Default legacy includes projects (for TL3), quotes optionally via include=quotes
    const include = parseInclude(urlObj);
    const includeQuotes = include.has("quotes"); // opt-in
    // (projects included always in legacy; TL3 needs it)
    let projectsBlock: { stylesBlock: any[] } = { stylesBlock: [] };
    try {
      projectsBlock = await buildProjectsBlock(allStyleIds);
    } catch (e) {
      return json({ error: String(e), where: "legacy.projects" }, 500, 0);
    }

    // quotes (optional)
    const quotesByStyleId = new Map<number, { slogans: any[]; key_text: any | null }>();
    if (includeQuotes) {
      const { data: sr, error: srErr } = await supabase
        .from("style_reference")
        .select("style_id, reference_id, relation_type, is_primary, sort_order, note")
        .in("style_id", allStyleIds.length ? allStyleIds : [-1]);

      if (srErr) return json({ error: srErr.message, where: "style_reference" }, 500, 0);

      const refIds: number[] = Array.from(new Set((sr ?? []).map((x: any) => x.reference_id)));

      let referenceEntries: any[] = [];
      if (refIds.length) {
        const { data: refs, error: refErr } = await supabase
          .from("reference_entries")
          .select("id, slug, kind, subtype, title_original, title_ru, text_original, text_ru, original_language, year, href, reliability, commentary")
          .in("id", refIds)
          .eq("is_published", true);

        if (refErr) return json({ error: refErr.message, where: "reference_entries" }, 500, 0);
        referenceEntries = refs ?? [];
      }

      const refById = new Map<number, any>(referenceEntries.map((r: any) => [r.id, r]));

      const refsByStyleId = new Map<number, any[]>();
      for (const link of (sr ?? []) as any[]) {
        const r = refById.get(link.reference_id);
        if (!r) continue;
        const list = refsByStyleId.get(link.style_id) ?? [];
        list.push({ ...r, relation_type: link.relation_type, sort_order: link.sort_order ?? 0 });
        refsByStyleId.set(link.style_id, list);
      }

      for (const sid of allStyleIds) {
        const rel = (refsByStyleId.get(sid) ?? []).sort((a: any, b: any) => (a.sort_order ?? 0) - (b.sort_order ?? 0));
        quotesByStyleId.set(sid, {
          slogans: rel.filter((x: any) => x.relation_type === "slogan"),
          key_text: rel.find((x: any) => x.relation_type === "key_text") ?? null,
        });
      }
    }

    const projectsByStyleId = new Map<number, any[]>(
      projectsBlock.stylesBlock.map((x: any) => [x.style_id, x.projects]),
    );

    const legacyStyles = stylesOutBase.map((s: any) => {
      const phenomenon_links = (phenomenonLinksByStyleId.get(s.id) ?? [])
        .slice()
        .sort((a: any, b: any) => (a.sort_order ?? 0) - (b.sort_order ?? 0));

      const q = quotesByStyleId.get(s.id);
      return {
        ...s,
        phenomenon_links,
        slogans: q ? q.slogans : [],
        key_text: q ? q.key_text : null,
        projects: projectsByStyleId.get(s.id) ?? [],
      };
    });

    return json(
      {
        version: 11,
        layer: "legacy",
        generated_at: new Date().toISOString(),
        phenomena: phenomenaOut,
        styles: legacyStyles,
      },
      200,
      120,
    );
  } catch (e) {
    return json({ error: String(e) }, 500, 0);
  }
});