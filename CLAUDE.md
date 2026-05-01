# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Language

Always respond in **Russian**.

## Knowledge Base (Obsidian Wiki)

Project thoughts, course concepts, and ideas are kept in the Obsidian vault:
**`e:/Dropbox/Obsidian/LearnANDThink/`**

**Rules:**
- Before making decisions about course content or structure — read relevant notes there first
- New ideas, concept notes, course structure decisions → write to that vault
- Format: Wiki with `[[internal links]]`, tags, frontmatter
- Claude-specific working notes → `e:/Dropbox/Obsidian/LearnANDThink/Claude/`
- Course concept → `e:/Dropbox/Obsidian/LearnANDThink/Квантовая Архитектура/00 Концепция курса.md`

The vault contains:
- `Квантовая Архитектура/` — new combined course (Architecture + Quantum Physics philosophy)
- `Анализ/` — GIS lab work sources (Obsidian drafts → deployed to gis.2vhutemas.ru)
- `Архитектура/` — architectural design materials

## Repository structure

This is a multi-folder VS Code workspace (`ArchSite.code-workspace`) spanning several directories:

| Folder | Purpose |
|--------|---------|
| `d:/WORK/ArchSite/` | DB schema, migrations, Supabase function source, utilities |
| `d:/WORK ON SERVER/site/` | Static sites served by Caddy |
| `d:/WORK ON SERVER/services/` | Deno app container |
| `d:/WORK ON SERVER/supabase/` | Self-hosted Supabase docker-compose stack |
| `d:/WORK ON SERVER/SETTINGS FILES/` | Server config files (Caddyfile etc.) |
| `e:/Dropbox/Obsidian/Tigra/GIS системы/` | Obsidian vault — source for GIS lecture media |

## Server

- **Host:** `178.72.152.16` (2vhutemas-vps), SSH as `root`
- **Web server:** Caddy with automatic HTTPS (Let's Encrypt, `admin@2vhutemas.ru`)
- **Domains:**
  - `gis.2vhutemas.ru` → `/var/www/gis` (GIS lecture site)
  - `2vhutemas.ru` → `/var/www/2vhutemas` + `/api/timeline*` → port 7070
  - `api.2vhutemas.ru` → port 8000

Deploy any file change to the server with `scp`:
```bash
scp "d:/WORK ON SERVER/site/gis/index.html" root@178.72.152.16:/var/www/gis/index.html
scp "d:/WORK ON SERVER/site/gis/lectures/002-qgis.md" root@178.72.152.16:/var/www/gis/lectures/
scp "d:/WORK ON SERVER/site/gis/media/file.png" root@178.72.152.16:/var/www/gis/media/
```

Restart a Docker container on server:
```bash
ssh root@178.72.152.16 "cd /opt/services && docker compose restart timeline"
ssh root@178.72.152.16 "cd /opt/supabase && docker compose restart supa_rest"
```

## GIS lecture site (`/var/www/gis`)

A **client-side SPA** — single `index.html` with no build step. Markdown is fetched and rendered at runtime using `marked.js v9.1.6` + `highlight.js v11.9.0`.

**Key JS globals in `index.html`:**
- `CHAPTERS` array — defines sidebar nav; `dual: true` + `files: {arcgis, qgis}` enables the software toggle for lectures 002/003
- `currentSoftware` — `'arcgis'` or `'qgis'`, persisted in `localStorage('gis-software')`
- `processMD(raw)` — converts Obsidian `![[file.png]]` → `<img src="media/file.png">`, strips `[[wiki links]]`
- `classifyCallouts(html)` — maps emoji prefix (💡/⚠️/✅) to CSS callout classes

**Lecture files** live in `lectures/` as Markdown. Naming convention:
- `002-arcgis.md` / `002-qgis.md` — dual-mode lectures
- `001.md`, `004.md`, `006.md` — placeholders ("В разработке")

**Media files** live in `media/`. Naming convention for QGIS illustrations:
- `qgis_002_01_basemap.png` — lecture number, sequence, short descriptor
- `qgis_003_01_import.png`

All media filenames must be **ASCII only, no spaces** — they are used directly as URL paths.

Obsidian source media is in `e:/Dropbox/Obsidian/Tigra/GIS системы/media/QGIS/`. When adding new images: rename them to Latin names in the source vault, then copy to `d:/WORK ON SERVER/site/gis/media/` and upload to server. Use the Python helper in `tools/rename_copy_qgis.py` — it works around Windows bash encoding issues by using `\uXXXX` escapes for Cyrillic paths.

## Timeline API (`app_timeline`)

**Docker:** `d:/WORK ON SERVER/services/docker-compose.yml` → container `app_timeline`, Deno on port 7070 (bound to 127.0.0.1).

**Source:** `d:/WORK ON SERVER/services/timeline/index.ts` (identical copy kept at `d:/WORK/ArchSite/SUPABASE FUNCTIONS/index.ts`).

The API is a single Deno HTTP handler. Query params:
- `layer=legacy|structure|quotes|projects` — response shape
- `style_id=N` or `style_ids=1,2,3` — required for `quotes`/`projects` layers
- `projectsPerStyle=N` (default 8, max 50)
- `include=quotes` — opt-in quotes in `legacy` mode

After editing `index.ts`, copy to server and restart:
```bash
scp "d:/WORK ON SERVER/services/timeline/index.ts" root@178.72.152.16:/opt/services/timeline/index.ts
ssh root@178.72.152.16 "cd /opt/services && docker compose restart timeline"
```

## Supabase stack

**Self-hosted** via `d:/WORK ON SERVER/supabase/docker-compose.yml`. Containers: `supa_db` (Postgres 17), `supa_auth` (GoTrue), `supa_rest` (PostgREST), `supa_storage`, `supa_kong` (API gateway on port 8000).

DB schema is tracked in `d:/WORK/ArchSite/supabase/migrations/`. The schema uses two parallel data models:
1. **Legacy tables** (`styles`, `phenomena`, `projects`, `authors`, `reference_entries`, `media_assets`) — used by the timeline API
2. **New entity model** (`entities`, `entity_kinds`, `links`, `object_profile`, `attachments`) — general-purpose graph structure visible in `DB STRUCTURE/mermaid_schema.md`

Key junction tables: `phenomenon_style`, `project_style`, `project_media`, `style_reference`, `reference_author`.

Apply a migration to the live DB:
```bash
ssh root@178.72.152.16 "docker exec -i supa_db psql -U postgres -d postgres" < migration.sql
```

One-off SQL snippets are kept in `d:/WORK/ArchSite/supabase/snippets/`.

## GIS Comments system (`gis_project`)

Student comments tied to specific lecture steps. Stored in Supabase, served via PostgREST.

**Table:** `public.gis_project` — migration at `supabase/migrations/20260416120000_gis_project.sql`

| Field | Type | Description |
|-------|------|-------------|
| `lecture_id` | text | `'002'`, `'007'`, `'intro'` |
| `software` | text | `'arcgis'` \| `'qgis'` \| `'common'` |
| `step_key` | text | First 60 chars of step text (Variant В — stable to renumbering) |
| `tg_handle` | text | Student's Telegram @nickname |
| `body` | text | Comment text, max 1000 chars |
| `hidden` | bool | Moderation flag, default false |
| `session_hash` | text | SHA-256 of localStorage session UUID (rate limit) |

**RLS:** `anon` can SELECT (where `NOT hidden`) and INSERT. No UPDATE/DELETE for anon.

**Rate limit:** 5 inserts per 10 minutes per `session_hash` — enforced by Postgres trigger.

**API keys:** значения JWT secret, ANON_KEY и SERVICE_KEY лежат в `.secrets/supabase-keys.md` (вне git, см. `.gitignore`). На сервере — в `/opt/services/.env` и `/opt/supabase/.env`. ANON_KEY в браузере виден как `GIS_KEY` в `gis/index.html` (он публичный по природе self-hosted Supabase, но в репо всё равно не публикуется).

**Moderation SQL:**
```sql
-- View new comments
SELECT created_at, lecture_id, software, step_key, tg_handle, body
FROM public.gis_project WHERE NOT hidden ORDER BY created_at DESC;

-- Hide a comment
UPDATE public.gis_project SET hidden = true WHERE id = N;
```

**JS globals in `index.html`:**
- `GIS_API`, `GIS_TABLE`, `GIS_KEY` — PostgREST endpoint and anon key
- `injectStepAnchors(container, lectureId, software)` — called after `marked.parse()`, finds all `<p>/<li>` starting with `<strong>N.</strong>` and injects 💬 buttons
- `toggleCommentPanel(lectureId, software, stepKey, anchorEl)` — opens/closes inline comment panel
- `fetchCounts(lectureId, software)` — loads comment counts for all steps in one request
- `STEP_NUM_RE` — regex `/^(\d+\.|[А-ЯA-Z]\.\d+\.|[А-ЯA-Z]\d+\.)/` for step detection

**Kong config** (`/home/kong/kong.yml` inside `supa_kong` container) — no JWT plugin, CORS `*`, no changes needed for comments.

**Path to Variant 2 (Telegram OAuth):** add `tg_id bigint` and `verified boolean DEFAULT false` columns to `gis_project` in a new migration. The `tg_handle` field already collects the handle for future verification.

## Lecture workflow (Obsidian → Server)

1. Edit lecture MD in Obsidian (`e:/Dropbox/Obsidian/Tigra/Анализ/`)
2. Use `!!!` prefix to mark corrections/new illustrations inline
3. Process `!!!` markers: rewrite in document style, add `![[image_name.png]]`
4. New images: rename to Latin in `GIS системы/media/QGIS/` (use Python script — bash `cp`/`mv` fails on Cyrillic paths), copy to `d:/WORK ON SERVER/site/gis/media/`
5. Copy MD to `d:/WORK ON SERVER/site/gis/lectures/`
6. Upload MD + new images to server via `scp`
