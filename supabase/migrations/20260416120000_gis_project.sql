-- ============================================================
-- gis_project: комментарии студентов к шагам лабораторных работ
-- ============================================================

CREATE TABLE public.gis_project (
  id            bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at    timestamptz NOT NULL DEFAULT now(),

  -- Идентификация места в лекции
  lecture_id    text NOT NULL,          -- '002', '007', 'intro'
  software      text NOT NULL DEFAULT 'common', -- 'arcgis' | 'qgis' | 'common'
  step_key      text NOT NULL,          -- первые слова текста шага (Вариант В)

  -- Автор
  tg_handle     text NOT NULL CHECK (char_length(tg_handle) BETWEEN 1 AND 64),

  -- Содержимое
  body          text NOT NULL CHECK (char_length(body) BETWEEN 2 AND 1000),

  -- Модерация
  hidden        boolean NOT NULL DEFAULT false,

  -- Rate limit: хэш session UUID из localStorage
  session_hash  text
);

-- Индекс для типичного запроса: все комментарии к шагу лекции
CREATE INDEX gis_project_lookup
  ON public.gis_project (lecture_id, software, step_key)
  WHERE NOT hidden;

-- Индекс для просмотра новых (модерация)
CREATE INDEX gis_project_recent
  ON public.gis_project (created_at DESC);

-- ── Rate limit ──────────────────────────────────────────────
-- Не более 5 комментариев с одной сессии за 10 минут

CREATE OR REPLACE FUNCTION public.gis_project_rate_ok(p_session text)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER AS $$
  SELECT count(*) < 5
  FROM public.gis_project
  WHERE session_hash = p_session
    AND created_at > now() - interval '10 minutes';
$$;

CREATE OR REPLACE FUNCTION public.gis_project_check_rate()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NEW.session_hash IS NOT NULL
     AND NOT public.gis_project_rate_ok(NEW.session_hash) THEN
    RAISE EXCEPTION 'rate_limit_exceeded' USING ERRCODE = 'P0001';
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER gis_project_rate_limit
  BEFORE INSERT ON public.gis_project
  FOR EACH ROW EXECUTE FUNCTION public.gis_project_check_rate();

-- ── Row Level Security ───────────────────────────────────────

ALTER TABLE public.gis_project ENABLE ROW LEVEL SECURITY;

-- anon: читать только не скрытые
CREATE POLICY "anon_select"
  ON public.gis_project FOR SELECT
  TO anon
  USING (NOT hidden);

-- anon: вставка разрешена (hidden всегда false при вставке)
CREATE POLICY "anon_insert"
  ON public.gis_project FOR INSERT
  TO anon
  WITH CHECK (NOT hidden);

-- ── Права ───────────────────────────────────────────────────

GRANT SELECT ON public.gis_project TO anon;
GRANT INSERT (lecture_id, software, step_key, tg_handle, body, session_hash)
  ON public.gis_project TO anon;
