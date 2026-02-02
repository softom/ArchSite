


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."author_entity_type" AS ENUM (
    'person',
    'organization'
);


ALTER TYPE "public"."author_entity_type" OWNER TO "postgres";


CREATE TYPE "public"."media_kind" AS ENUM (
    'photo',
    'sketch',
    'drawing',
    'technical_scheme',
    'render',
    'other'
);


ALTER TYPE "public"."media_kind" OWNER TO "postgres";


CREATE TYPE "public"."project_kind" AS ENUM (
    'urban_concept',
    'environment_object',
    'architecture_object',
    'memorandum',
    'theory_concept',
    'competition_entry',
    'study_work'
);


ALTER TYPE "public"."project_kind" OWNER TO "postgres";


CREATE TYPE "public"."reference_kind" AS ENUM (
    'quote',
    'text'
);


ALTER TYPE "public"."reference_kind" OWNER TO "postgres";


COMMENT ON TYPE "public"."reference_kind" IS 'Тип записи в reference_entries: quote (цитата/лозунг) или text (книга/статья/манифест/каталог и т.п.).';



CREATE OR REPLACE FUNCTION "public"."set_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;


ALTER FUNCTION "public"."set_updated_at"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."set_updated_at"() IS 'Триггерная функция: обновляет updated_at при UPDATE.';



CREATE OR REPLACE FUNCTION "public"."whoami"() RETURNS "jsonb"
    LANGUAGE "sql"
    AS $$
  select jsonb_build_object(
    'current_user', current_user,
    'auth_role', auth.role(),
    'auth_uid', auth.uid()
  );
$$;


ALTER FUNCTION "public"."whoami"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."authors" (
    "id" bigint NOT NULL,
    "slug" "text" NOT NULL,
    "full_name" "text" NOT NULL,
    "birth_year" integer,
    "death_year" integer,
    "wiki_url" "text",
    "bio_short" "text",
    "is_published" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "entity_type" "public"."author_entity_type" DEFAULT 'person'::"public"."author_entity_type",
    "website_url" "text"
);


ALTER TABLE "public"."authors" OWNER TO "postgres";


COMMENT ON TABLE "public"."authors" IS 'Авторы: архитекторы, теоретики, кураторы. Отдельно от объектов и источников.';



COMMENT ON COLUMN "public"."authors"."id" IS 'PK.';



COMMENT ON COLUMN "public"."authors"."slug" IS 'Уникальный идентификатор (kebab-case).';



COMMENT ON COLUMN "public"."authors"."full_name" IS 'Имя как принято (обычно на оригинальном языке/в англ. транскрипции).';



COMMENT ON COLUMN "public"."authors"."birth_year" IS 'Год рождения (опционально).';



COMMENT ON COLUMN "public"."authors"."death_year" IS 'Год смерти (опционально).';



COMMENT ON COLUMN "public"."authors"."wiki_url" IS 'Ссылка на Wikipedia/внешний справочник (для карточки).';



COMMENT ON COLUMN "public"."authors"."bio_short" IS 'Короткая справка (1–2 строки).';



COMMENT ON COLUMN "public"."authors"."is_published" IS 'Показывать на сайте.';



COMMENT ON COLUMN "public"."authors"."created_at" IS 'Дата создания.';



COMMENT ON COLUMN "public"."authors"."updated_at" IS 'Дата последнего изменения (авто).';



COMMENT ON COLUMN "public"."authors"."entity_type" IS 'Тип автора: person (человек) или organization (компания/бюро/институт).';



COMMENT ON COLUMN "public"."authors"."website_url" IS 'Официальный сайт/страница организации или автора (если есть).';



CREATE SEQUENCE IF NOT EXISTS "public"."authors_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."authors_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."authors_id_seq" OWNED BY "public"."authors"."id";



CREATE TABLE IF NOT EXISTS "public"."features" (
    "id" bigint NOT NULL,
    "slug" "text" NOT NULL,
    "title_ru" "text" NOT NULL,
    "title_en" "text",
    "description" "text",
    "sort_order" integer DEFAULT 0,
    "is_published" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."features" OWNER TO "postgres";


COMMENT ON TABLE "public"."features" IS 'Справочник особенностей/тегов для учебной выборки объектов.';



COMMENT ON COLUMN "public"."features"."slug" IS 'Уникальный идентификатор (kebab-case).';



COMMENT ON COLUMN "public"."features"."title_ru" IS 'Название особенности на русском.';



COMMENT ON COLUMN "public"."features"."title_en" IS 'Английский термин (опционально).';



COMMENT ON COLUMN "public"."features"."description" IS 'Пояснение/критерий особенности.';



COMMENT ON COLUMN "public"."features"."sort_order" IS 'Порядок в списках.';



COMMENT ON COLUMN "public"."features"."is_published" IS 'Показывать в публичных фильтрах/подсказках.';



CREATE SEQUENCE IF NOT EXISTS "public"."features_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."features_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."features_id_seq" OWNED BY "public"."features"."id";



CREATE TABLE IF NOT EXISTS "public"."media_assets" (
    "id" bigint NOT NULL,
    "slug" "text",
    "storage_bucket" "text" DEFAULT 'project-images'::"text" NOT NULL,
    "storage_path" "text" NOT NULL,
    "public_url" "text",
    "mime_type" "text",
    "width" integer,
    "height" integer,
    "caption_ru" "text",
    "caption_original" "text",
    "credit" "text",
    "source_url" "text",
    "license" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "kind" "public"."media_kind" DEFAULT 'photo'::"public"."media_kind",
    "description_ru" "text",
    "is_published" boolean DEFAULT true
);


ALTER TABLE "public"."media_assets" OWNER TO "postgres";


COMMENT ON TABLE "public"."media_assets" IS 'Медиа-ассеты (фото/картинки) для проектов, хранение файлов в Supabase Storage.';



COMMENT ON COLUMN "public"."media_assets"."storage_bucket" IS 'Имя Storage bucket.';



COMMENT ON COLUMN "public"."media_assets"."storage_path" IS 'Путь внутри bucket.';



COMMENT ON COLUMN "public"."media_assets"."public_url" IS 'Публичный URL (если bucket public).';



COMMENT ON COLUMN "public"."media_assets"."caption_ru" IS 'Подпись на русском.';



COMMENT ON COLUMN "public"."media_assets"."caption_original" IS 'Подпись на оригинальном языке.';



COMMENT ON COLUMN "public"."media_assets"."kind" IS 'Тип изображения: photo/sketch/drawing/technical_scheme/render/other.';



COMMENT ON COLUMN "public"."media_assets"."description_ru" IS 'Описание (для учебных целей): что на изображении, на что смотреть.';



CREATE SEQUENCE IF NOT EXISTS "public"."media_assets_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."media_assets_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."media_assets_id_seq" OWNED BY "public"."media_assets"."id";



CREATE TABLE IF NOT EXISTS "public"."phenomena" (
    "id" bigint NOT NULL,
    "slug" "text" NOT NULL,
    "title_ru" "text" NOT NULL,
    "title_en" "text",
    "date_start_year" integer,
    "date_end_year" integer,
    "short_definition" "text",
    "color" "text",
    "sort_order" integer DEFAULT 0,
    "is_published" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "image_media_id" bigint
);


ALTER TABLE "public"."phenomena" OWNER TO "postgres";


COMMENT ON TABLE "public"."phenomena" IS 'Заглавные явления/парадигмы (например: Модернизм, Постмодернизм). Верхний уровень иерархии.';



COMMENT ON COLUMN "public"."phenomena"."id" IS 'PK.';



COMMENT ON COLUMN "public"."phenomena"."slug" IS 'Уникальный стабильный идентификатор (kebab-case). Используется для upsert/импорта.';



COMMENT ON COLUMN "public"."phenomena"."title_ru" IS 'Название на русском (для сайта).';



COMMENT ON COLUMN "public"."phenomena"."title_en" IS 'Английский термин/вариант названия (опционально).';



COMMENT ON COLUMN "public"."phenomena"."date_start_year" IS 'Примерное начало (год). Может быть NULL.';



COMMENT ON COLUMN "public"."phenomena"."date_end_year" IS 'Примерный конец (год). NULL = "н.в." или неизвестно.';



COMMENT ON COLUMN "public"."phenomena"."short_definition" IS 'Короткое определение (1–2 предложения) для левого столбца.';



COMMENT ON COLUMN "public"."phenomena"."color" IS 'Цвет для UI (например #RRGGBB).';



COMMENT ON COLUMN "public"."phenomena"."sort_order" IS 'Порядок отображения (ручная сортировка).';



COMMENT ON COLUMN "public"."phenomena"."is_published" IS 'Показывать на публичном сайте.';



COMMENT ON COLUMN "public"."phenomena"."created_at" IS 'Дата создания записи.';



COMMENT ON COLUMN "public"."phenomena"."updated_at" IS 'Дата последнего изменения (авто).';



CREATE SEQUENCE IF NOT EXISTS "public"."phenomena_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."phenomena_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."phenomena_id_seq" OWNED BY "public"."phenomena"."id";



CREATE TABLE IF NOT EXISTS "public"."phenomenon_style" (
    "phenomenon_id" bigint NOT NULL,
    "style_id" bigint NOT NULL,
    "is_primary" boolean DEFAULT false,
    "sort_order" integer DEFAULT 0,
    "note" "text"
);


ALTER TABLE "public"."phenomenon_style" OWNER TO "postgres";


COMMENT ON TABLE "public"."phenomenon_style" IS 'Связь M:N: стиль может относиться к нескольким явлениям. is_primary — главный "зонт" для UI.';



COMMENT ON COLUMN "public"."phenomenon_style"."phenomenon_id" IS 'FK -> phenomena.id';



COMMENT ON COLUMN "public"."phenomenon_style"."style_id" IS 'FK -> styles.id';



COMMENT ON COLUMN "public"."phenomenon_style"."is_primary" IS 'Если true — это основной зонт для стиля (используем в sticky-колонке).';



COMMENT ON COLUMN "public"."phenomenon_style"."sort_order" IS 'Порядок стилей внутри конкретного явления (ручная сортировка).';



COMMENT ON COLUMN "public"."phenomenon_style"."note" IS 'Редакторская заметка/пояснение классификации.';



CREATE TABLE IF NOT EXISTS "public"."project_author" (
    "project_id" bigint NOT NULL,
    "author_id" bigint NOT NULL,
    "role" "text" DEFAULT 'architect'::"text" NOT NULL
);


ALTER TABLE "public"."project_author" OWNER TO "postgres";


COMMENT ON TABLE "public"."project_author" IS 'Связь M:N: авторы объекта. role: architect/engineer/client и т.п.';



COMMENT ON COLUMN "public"."project_author"."project_id" IS 'FK -> projects.id';



COMMENT ON COLUMN "public"."project_author"."author_id" IS 'FK -> authors.id';



COMMENT ON COLUMN "public"."project_author"."role" IS 'Роль в проекте.';



CREATE TABLE IF NOT EXISTS "public"."project_feature" (
    "project_id" bigint NOT NULL,
    "feature_id" bigint NOT NULL,
    "note" "text"
);


ALTER TABLE "public"."project_feature" OWNER TO "postgres";


COMMENT ON TABLE "public"."project_feature" IS 'Связь объект–особенность (M:N).';



CREATE TABLE IF NOT EXISTS "public"."project_media" (
    "project_id" bigint NOT NULL,
    "media_id" bigint NOT NULL,
    "sort_order" integer DEFAULT 0,
    "is_cover" boolean DEFAULT false,
    "note" "text"
);


ALTER TABLE "public"."project_media" OWNER TO "postgres";


COMMENT ON TABLE "public"."project_media" IS 'Связь объект–медиа (M:N) + порядок и обложка.';



CREATE TABLE IF NOT EXISTS "public"."project_style" (
    "project_id" bigint NOT NULL,
    "style_id" bigint NOT NULL,
    "confidence" "text" DEFAULT 'primary'::"text",
    "note" "text"
);


ALTER TABLE "public"."project_style" OWNER TO "postgres";


COMMENT ON TABLE "public"."project_style" IS 'Связь M:N: какие стили релевантны объекту. confidence: primary/secondary/mentioned.';



COMMENT ON COLUMN "public"."project_style"."project_id" IS 'FK -> projects.id';



COMMENT ON COLUMN "public"."project_style"."style_id" IS 'FK -> styles.id';



COMMENT ON COLUMN "public"."project_style"."confidence" IS 'Степень уверенности/важности отнесения.';



COMMENT ON COLUMN "public"."project_style"."note" IS 'Примечание/обоснование.';



CREATE TABLE IF NOT EXISTS "public"."projects" (
    "id" bigint NOT NULL,
    "slug" "text" NOT NULL,
    "title_original" "text" NOT NULL,
    "title_ru" "text",
    "year_start" integer,
    "year_end" integer,
    "city" "text",
    "country" "text",
    "typology" "text",
    "description_short" "text",
    "wiki_url" "text",
    "is_published" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "slogan_original" "text",
    "slogan_ru" "text",
    "slogan_language" "text",
    "slogan_source_url" "text",
    "lat" double precision,
    "lon" double precision,
    "project_kind" "public"."project_kind" DEFAULT 'architecture_object'::"public"."project_kind"
);


ALTER TABLE "public"."projects" OWNER TO "postgres";


COMMENT ON TABLE "public"."projects" IS 'Архитектурные объекты/проекты. Привязка к стилям и авторам через join-таблицы.';



COMMENT ON COLUMN "public"."projects"."id" IS 'PK.';



COMMENT ON COLUMN "public"."projects"."slug" IS 'Уникальный идентификатор (kebab-case).';



COMMENT ON COLUMN "public"."projects"."title_original" IS 'Оригинальное название объекта (например "Villa Savoye").';



COMMENT ON COLUMN "public"."projects"."title_ru" IS 'Русское название (если принято).';



COMMENT ON COLUMN "public"."projects"."year_start" IS 'Год начала/проектирования (если известен).';



COMMENT ON COLUMN "public"."projects"."year_end" IS 'Год завершения (если известен).';



COMMENT ON COLUMN "public"."projects"."city" IS 'Город.';



COMMENT ON COLUMN "public"."projects"."country" IS 'Страна.';



COMMENT ON COLUMN "public"."projects"."typology" IS 'Типология: housing/museum/office/research и т.п.';



COMMENT ON COLUMN "public"."projects"."description_short" IS 'Короткое описание/пояснение (1–2 строки).';



COMMENT ON COLUMN "public"."projects"."wiki_url" IS 'Ссылка на Wikipedia/внешний справочник.';



COMMENT ON COLUMN "public"."projects"."is_published" IS 'Показывать на сайте.';



COMMENT ON COLUMN "public"."projects"."created_at" IS 'Дата создания.';



COMMENT ON COLUMN "public"."projects"."updated_at" IS 'Дата последнего изменения (авто).';



COMMENT ON COLUMN "public"."projects"."slogan_original" IS 'Слоган/идея объекта (оригинал).';



COMMENT ON COLUMN "public"."projects"."slogan_ru" IS 'Перевод слогана/идеи на русский (если нужен).';



COMMENT ON COLUMN "public"."projects"."slogan_language" IS 'Язык оригинала (en/de/fr/ru...).';



COMMENT ON COLUMN "public"."projects"."slogan_source_url" IS 'Ссылка на источник слогана/описания идеи.';



COMMENT ON COLUMN "public"."projects"."lat" IS 'WGS84 latitude (широта).';



COMMENT ON COLUMN "public"."projects"."lon" IS 'WGS84 longitude (долгота).';



COMMENT ON COLUMN "public"."projects"."project_kind" IS 'Вид записи: архитектурный объект, градостроительная концепция, меморандум и т.д.';



CREATE SEQUENCE IF NOT EXISTS "public"."projects_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."projects_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."projects_id_seq" OWNED BY "public"."projects"."id";



CREATE TABLE IF NOT EXISTS "public"."reference_author" (
    "reference_id" bigint NOT NULL,
    "author_id" bigint NOT NULL,
    "role" "text" DEFAULT 'author'::"text" NOT NULL
);


ALTER TABLE "public"."reference_author" OWNER TO "postgres";


COMMENT ON TABLE "public"."reference_author" IS 'Связь M:N: авторы источников/цитат. role: author/editor/curator/attributed_to/said_by и т.п.';



COMMENT ON COLUMN "public"."reference_author"."reference_id" IS 'FK -> reference_entries.id';



COMMENT ON COLUMN "public"."reference_author"."author_id" IS 'FK -> authors.id';



COMMENT ON COLUMN "public"."reference_author"."role" IS 'Роль автора в источнике/цитате.';



CREATE TABLE IF NOT EXISTS "public"."reference_entries" (
    "id" bigint NOT NULL,
    "slug" "text" NOT NULL,
    "kind" "public"."reference_kind" NOT NULL,
    "subtype" "text",
    "title_original" "text",
    "title_ru" "text",
    "text_original" "text",
    "text_ru" "text",
    "original_language" "text",
    "year" integer,
    "href" "text",
    "reliability" "text",
    "commentary" "text",
    "is_published" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."reference_entries" OWNER TO "postgres";


COMMENT ON TABLE "public"."reference_entries" IS 'Единая таблица для: (1) лозунгов/цитат и (2) ключевых текстов/источников. Привязка к стилям через style_reference.';



COMMENT ON COLUMN "public"."reference_entries"."id" IS 'PK.';



COMMENT ON COLUMN "public"."reference_entries"."slug" IS 'Уникальный идентификатор (kebab-case).';



COMMENT ON COLUMN "public"."reference_entries"."kind" IS 'quote | text.';



COMMENT ON COLUMN "public"."reference_entries"."subtype" IS 'Уточнение типа: book/article/manifesto/catalog/exhibition/inscription/lecture/motto и т.д.';



COMMENT ON COLUMN "public"."reference_entries"."title_original" IS 'Оригинальное название (для text) или короткий заголовок (для quote), если нужно.';



COMMENT ON COLUMN "public"."reference_entries"."title_ru" IS 'Русское название источника/этикетка (если есть).';



COMMENT ON COLUMN "public"."reference_entries"."text_original" IS 'Оригинальный текст цитаты или ключевой фрагмент (если уместно).';



COMMENT ON COLUMN "public"."reference_entries"."text_ru" IS 'Перевод цитаты на русский или RU-аннотация источника.';



COMMENT ON COLUMN "public"."reference_entries"."original_language" IS 'Язык оригинала: en/de/fr/ru...';



COMMENT ON COLUMN "public"."reference_entries"."year" IS 'Год (если известен).';



COMMENT ON COLUMN "public"."reference_entries"."href" IS 'Ссылка на источник (первоисточник предпочтителен; иначе стабильная вторичная страница).';



COMMENT ON COLUMN "public"."reference_entries"."reliability" IS 'solid | common_attrib | disputed (для учебной честности).';



COMMENT ON COLUMN "public"."reference_entries"."commentary" IS 'Пояснение контекста/атрибуции.';



COMMENT ON COLUMN "public"."reference_entries"."is_published" IS 'Показывать на сайте.';



COMMENT ON COLUMN "public"."reference_entries"."created_at" IS 'Дата создания.';



COMMENT ON COLUMN "public"."reference_entries"."updated_at" IS 'Дата последнего изменения (авто).';



CREATE SEQUENCE IF NOT EXISTS "public"."reference_entries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."reference_entries_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."reference_entries_id_seq" OWNED BY "public"."reference_entries"."id";



CREATE TABLE IF NOT EXISTS "public"."style_reference" (
    "style_id" bigint NOT NULL,
    "reference_id" bigint NOT NULL,
    "relation_type" "text" NOT NULL,
    "is_primary" boolean DEFAULT false,
    "sort_order" integer DEFAULT 0,
    "note" "text"
);


ALTER TABLE "public"."style_reference" OWNER TO "postgres";


COMMENT ON TABLE "public"."style_reference" IS 'Связь M:N: что относится к стилю. relation_type: лозунг, ключевой текст (строго 1), доп. чтение, контекст.';



COMMENT ON COLUMN "public"."style_reference"."style_id" IS 'FK -> styles.id';



COMMENT ON COLUMN "public"."style_reference"."reference_id" IS 'FK -> reference_entries.id';



COMMENT ON COLUMN "public"."style_reference"."relation_type" IS 'slogan | key_text | reading | context.';



COMMENT ON COLUMN "public"."style_reference"."is_primary" IS 'Для лозунгов: главный лозунг; для прочего — как понадобится.';



COMMENT ON COLUMN "public"."style_reference"."sort_order" IS 'Порядок вывода внутри стиля.';



COMMENT ON COLUMN "public"."style_reference"."note" IS 'Примечание (почему это ключевое/как читать).';



CREATE TABLE IF NOT EXISTS "public"."styles" (
    "id" bigint NOT NULL,
    "slug" "text" NOT NULL,
    "title_ru" "text" NOT NULL,
    "title_en" "text",
    "date_start_year" integer,
    "date_end_year" integer,
    "one_liner" "text",
    "description" "text",
    "is_published" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "color" "text",
    "image_media_id" bigint
);


ALTER TABLE "public"."styles" OWNER TO "postgres";


COMMENT ON TABLE "public"."styles" IS 'Стили/направления. Могут относиться к нескольким заглавным явлениям через phenomenon_style.';



COMMENT ON COLUMN "public"."styles"."id" IS 'PK.';



COMMENT ON COLUMN "public"."styles"."slug" IS 'Уникальный стабильный идентификатор (kebab-case).';



COMMENT ON COLUMN "public"."styles"."title_ru" IS 'Русское название (для интерфейса/обучения).';



COMMENT ON COLUMN "public"."styles"."title_en" IS 'Английский термин/экзоним (обязательно для ключевых терминов, опционально).';



COMMENT ON COLUMN "public"."styles"."date_start_year" IS 'Примерное начало (год).';



COMMENT ON COLUMN "public"."styles"."date_end_year" IS 'Примерный конец (год) или NULL для "н.в.".';



COMMENT ON COLUMN "public"."styles"."one_liner" IS 'Супер-короткое описание (1 строка) для средней колонки/подсказки.';



COMMENT ON COLUMN "public"."styles"."description" IS 'Развёрнутое описание для правой колонки (можно Markdown).';



COMMENT ON COLUMN "public"."styles"."is_published" IS 'Показывать на публичном сайте.';



COMMENT ON COLUMN "public"."styles"."created_at" IS 'Дата создания.';



COMMENT ON COLUMN "public"."styles"."updated_at" IS 'Дата последнего изменения (авто).';



COMMENT ON COLUMN "public"."styles"."color" IS 'HEX цвет стиля, например #C04848';



CREATE SEQUENCE IF NOT EXISTS "public"."styles_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."styles_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."styles_id_seq" OWNED BY "public"."styles"."id";



CREATE OR REPLACE VIEW "public"."v_project_card_published" AS
 SELECT "id",
    "slug",
    "title_original",
    "title_ru",
    "year_start",
    "year_end",
    "city",
    "country",
    "typology",
    "description_short",
    "wiki_url",
    COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('slug', "s"."slug", 'title_ru', "s"."title_ru", 'title_en', "s"."title_en", 'date_start_year', "s"."date_start_year", 'date_end_year', "s"."date_end_year", 'confidence', "ps"."confidence") ORDER BY "s"."date_start_year", "s"."title_ru") AS "jsonb_agg"
           FROM ("public"."project_style" "ps"
             JOIN "public"."styles" "s" ON (("s"."id" = "ps"."style_id")))
          WHERE (("ps"."project_id" = "p"."id") AND ("s"."is_published" = true))), '[]'::"jsonb") AS "styles",
    COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('slug', "a"."slug", 'full_name', "a"."full_name", 'birth_year', "a"."birth_year", 'death_year', "a"."death_year", 'wiki_url', "a"."wiki_url", 'role', "pa"."role") ORDER BY "a"."full_name") AS "jsonb_agg"
           FROM ("public"."project_author" "pa"
             JOIN "public"."authors" "a" ON (("a"."id" = "pa"."author_id")))
          WHERE (("pa"."project_id" = "p"."id") AND ("a"."is_published" = true))), '[]'::"jsonb") AS "authors"
   FROM "public"."projects" "p"
  WHERE ("is_published" = true);


ALTER VIEW "public"."v_project_card_published" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_style_card_published" AS
 SELECT "id",
    "slug",
    "title_ru",
    "title_en",
    "date_start_year",
    "date_end_year",
    "one_liner",
    "description",
    COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('phenomenon_id', "p"."id", 'slug', "p"."slug", 'title_ru', "p"."title_ru", 'title_en', "p"."title_en", 'date_start_year', "p"."date_start_year", 'date_end_year', "p"."date_end_year", 'color', "p"."color", 'is_primary', "ps"."is_primary", 'sort_order', "ps"."sort_order", 'note', "ps"."note") ORDER BY "ps"."sort_order") AS "jsonb_agg"
           FROM ("public"."phenomenon_style" "ps"
             JOIN "public"."phenomena" "p" ON (("p"."id" = "ps"."phenomenon_id")))
          WHERE (("ps"."style_id" = "s"."id") AND ("p"."is_published" = true))), '[]'::"jsonb") AS "phenomena",
    COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('slug', "r"."slug", 'kind', "r"."kind", 'subtype', "r"."subtype", 'text_original', "r"."text_original", 'text_ru', "r"."text_ru", 'original_language', "r"."original_language", 'year', "r"."year", 'href', "r"."href", 'reliability', "r"."reliability", 'commentary', "r"."commentary", 'is_primary', "sr"."is_primary", 'sort_order', "sr"."sort_order", 'authors', COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('slug', "a"."slug", 'full_name', "a"."full_name", 'birth_year', "a"."birth_year", 'death_year', "a"."death_year", 'wiki_url', "a"."wiki_url", 'role', "ra"."role") ORDER BY "a"."full_name") AS "jsonb_agg"
                   FROM ("public"."reference_author" "ra"
                     JOIN "public"."authors" "a" ON (("a"."id" = "ra"."author_id")))
                  WHERE (("ra"."reference_id" = "r"."id") AND ("a"."is_published" = true))), '[]'::"jsonb")) ORDER BY "sr"."sort_order") AS "jsonb_agg"
           FROM ("public"."style_reference" "sr"
             JOIN "public"."reference_entries" "r" ON (("r"."id" = "sr"."reference_id")))
          WHERE (("sr"."style_id" = "s"."id") AND ("sr"."relation_type" = 'slogan'::"text") AND ("r"."is_published" = true))), '[]'::"jsonb") AS "slogans",
    ( SELECT "jsonb_build_object"('slug', "r"."slug", 'kind', "r"."kind", 'subtype', "r"."subtype", 'title_original', "r"."title_original", 'title_ru', "r"."title_ru", 'year', "r"."year", 'href', "r"."href", 'reliability', "r"."reliability", 'commentary', "r"."commentary", 'authors', COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('slug', "a"."slug", 'full_name', "a"."full_name", 'birth_year', "a"."birth_year", 'death_year', "a"."death_year", 'wiki_url', "a"."wiki_url", 'role', "ra"."role") ORDER BY "a"."full_name") AS "jsonb_agg"
                   FROM ("public"."reference_author" "ra"
                     JOIN "public"."authors" "a" ON (("a"."id" = "ra"."author_id")))
                  WHERE (("ra"."reference_id" = "r"."id") AND ("a"."is_published" = true))), '[]'::"jsonb")) AS "jsonb_build_object"
           FROM ("public"."style_reference" "sr"
             JOIN "public"."reference_entries" "r" ON (("r"."id" = "sr"."reference_id")))
          WHERE (("sr"."style_id" = "s"."id") AND ("sr"."relation_type" = 'key_text'::"text") AND ("r"."is_published" = true))
         LIMIT 1) AS "key_text",
    COALESCE(( SELECT "jsonb_agg"("jsonb_build_object"('slug', "p"."slug", 'title_original', "p"."title_original", 'title_ru', "p"."title_ru", 'year_start', "p"."year_start", 'year_end', "p"."year_end", 'city', "p"."city", 'country', "p"."country", 'typology', "p"."typology", 'wiki_url', "p"."wiki_url", 'description_short', "p"."description_short", 'confidence', "pst"."confidence") ORDER BY "p"."year_start", "p"."title_original") AS "jsonb_agg"
           FROM ("public"."project_style" "pst"
             JOIN "public"."projects" "p" ON (("p"."id" = "pst"."project_id")))
          WHERE (("pst"."style_id" = "s"."id") AND ("p"."is_published" = true))), '[]'::"jsonb") AS "projects"
   FROM "public"."styles" "s"
  WHERE ("is_published" = true);


ALTER VIEW "public"."v_style_card_published" OWNER TO "postgres";


ALTER TABLE ONLY "public"."authors" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."authors_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."features" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."features_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."media_assets" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."media_assets_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."phenomena" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."phenomena_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."projects" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."projects_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."reference_entries" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."reference_entries_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."styles" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."styles_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."authors"
    ADD CONSTRAINT "authors_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."authors"
    ADD CONSTRAINT "authors_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."features"
    ADD CONSTRAINT "features_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."features"
    ADD CONSTRAINT "features_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."media_assets"
    ADD CONSTRAINT "media_assets_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."media_assets"
    ADD CONSTRAINT "media_assets_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."phenomena"
    ADD CONSTRAINT "phenomena_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."phenomena"
    ADD CONSTRAINT "phenomena_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."phenomenon_style"
    ADD CONSTRAINT "phenomenon_style_pkey" PRIMARY KEY ("phenomenon_id", "style_id");



ALTER TABLE ONLY "public"."project_author"
    ADD CONSTRAINT "project_author_pkey" PRIMARY KEY ("project_id", "author_id", "role");



ALTER TABLE ONLY "public"."project_feature"
    ADD CONSTRAINT "project_feature_pkey" PRIMARY KEY ("project_id", "feature_id");



ALTER TABLE ONLY "public"."project_media"
    ADD CONSTRAINT "project_media_pkey" PRIMARY KEY ("project_id", "media_id");



ALTER TABLE ONLY "public"."project_style"
    ADD CONSTRAINT "project_style_pkey" PRIMARY KEY ("project_id", "style_id");



ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."reference_author"
    ADD CONSTRAINT "reference_author_pkey" PRIMARY KEY ("reference_id", "author_id", "role");



ALTER TABLE ONLY "public"."reference_entries"
    ADD CONSTRAINT "reference_entries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reference_entries"
    ADD CONSTRAINT "reference_entries_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."style_reference"
    ADD CONSTRAINT "style_reference_pkey" PRIMARY KEY ("style_id", "reference_id", "relation_type");



ALTER TABLE ONLY "public"."styles"
    ADD CONSTRAINT "styles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."styles"
    ADD CONSTRAINT "styles_slug_key" UNIQUE ("slug");



CREATE INDEX "idx_phenomenon_style_phenomenon_id" ON "public"."phenomenon_style" USING "btree" ("phenomenon_id");



CREATE INDEX "idx_phenomenon_style_style_id" ON "public"."phenomenon_style" USING "btree" ("style_id");



CREATE INDEX "idx_project_feature_feature" ON "public"."project_feature" USING "btree" ("feature_id");



CREATE INDEX "idx_project_media_project" ON "public"."project_media" USING "btree" ("project_id");



CREATE INDEX "idx_project_style_style_id" ON "public"."project_style" USING "btree" ("style_id");



CREATE INDEX "idx_reference_author_reference_id" ON "public"."reference_author" USING "btree" ("reference_id");



CREATE INDEX "idx_style_reference_reference_id" ON "public"."style_reference" USING "btree" ("reference_id");



CREATE INDEX "idx_style_reference_style_id" ON "public"."style_reference" USING "btree" ("style_id");



CREATE UNIQUE INDEX "ux_style_one_key_text" ON "public"."style_reference" USING "btree" ("style_id") WHERE ("relation_type" = 'key_text'::"text");



COMMENT ON INDEX "public"."ux_style_one_key_text" IS 'Ограничение: у каждого стиля не более одного key_text.';



CREATE OR REPLACE TRIGGER "trg_authors_updated_at" BEFORE UPDATE ON "public"."authors" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "trg_features_updated_at" BEFORE UPDATE ON "public"."features" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "trg_media_assets_updated_at" BEFORE UPDATE ON "public"."media_assets" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "trg_phenomena_updated_at" BEFORE UPDATE ON "public"."phenomena" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "trg_projects_updated_at" BEFORE UPDATE ON "public"."projects" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "trg_reference_entries_updated_at" BEFORE UPDATE ON "public"."reference_entries" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "trg_styles_updated_at" BEFORE UPDATE ON "public"."styles" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



ALTER TABLE ONLY "public"."phenomena"
    ADD CONSTRAINT "phenomena_image_media_id_fkey" FOREIGN KEY ("image_media_id") REFERENCES "public"."media_assets"("id");



ALTER TABLE ONLY "public"."phenomenon_style"
    ADD CONSTRAINT "phenomenon_style_phenomenon_id_fkey" FOREIGN KEY ("phenomenon_id") REFERENCES "public"."phenomena"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."phenomenon_style"
    ADD CONSTRAINT "phenomenon_style_style_id_fkey" FOREIGN KEY ("style_id") REFERENCES "public"."styles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_author"
    ADD CONSTRAINT "project_author_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."authors"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_author"
    ADD CONSTRAINT "project_author_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_feature"
    ADD CONSTRAINT "project_feature_feature_id_fkey" FOREIGN KEY ("feature_id") REFERENCES "public"."features"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_feature"
    ADD CONSTRAINT "project_feature_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_media"
    ADD CONSTRAINT "project_media_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "public"."media_assets"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_media"
    ADD CONSTRAINT "project_media_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_style"
    ADD CONSTRAINT "project_style_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_style"
    ADD CONSTRAINT "project_style_style_id_fkey" FOREIGN KEY ("style_id") REFERENCES "public"."styles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reference_author"
    ADD CONSTRAINT "reference_author_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."authors"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reference_author"
    ADD CONSTRAINT "reference_author_reference_id_fkey" FOREIGN KEY ("reference_id") REFERENCES "public"."reference_entries"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."style_reference"
    ADD CONSTRAINT "style_reference_reference_id_fkey" FOREIGN KEY ("reference_id") REFERENCES "public"."reference_entries"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."style_reference"
    ADD CONSTRAINT "style_reference_style_id_fkey" FOREIGN KEY ("style_id") REFERENCES "public"."styles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."styles"
    ADD CONSTRAINT "styles_image_media_id_fkey" FOREIGN KEY ("image_media_id") REFERENCES "public"."media_assets"("id");



ALTER TABLE "public"."features" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "features_editor_all" ON "public"."features" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "features_public_read" ON "public"."features" FOR SELECT USING (("is_published" = true));



CREATE POLICY "ma_delete_auth" ON "public"."media_assets" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "ma_select_auth" ON "public"."media_assets" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "ma_update_auth" ON "public"."media_assets" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "ma_write_auth" ON "public"."media_assets" FOR INSERT TO "authenticated" WITH CHECK (true);



ALTER TABLE "public"."media_assets" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "media_assets_editor_all" ON "public"."media_assets" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "media_assets_public_read" ON "public"."media_assets" FOR SELECT USING (("is_published" = true));



CREATE POLICY "media_assets_service_read" ON "public"."media_assets" FOR SELECT TO "service_role" USING (true);



CREATE POLICY "pm_delete_auth" ON "public"."project_media" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "pm_select_auth" ON "public"."project_media" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "pm_update_auth" ON "public"."project_media" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "pm_write_auth" ON "public"."project_media" FOR INSERT TO "authenticated" WITH CHECK (true);



ALTER TABLE "public"."project_author" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "project_author_editor_all" ON "public"."project_author" TO "authenticated" USING (true) WITH CHECK (true);



ALTER TABLE "public"."project_media" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "project_media_service_read" ON "public"."project_media" FOR SELECT TO "service_role" USING (true);



ALTER TABLE "public"."project_style" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "project_style_editor_all" ON "public"."project_style" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "project_style_service_read" ON "public"."project_style" FOR SELECT TO "service_role" USING (true);



ALTER TABLE "public"."projects" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "projects_editor_all" ON "public"."projects" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "projects_public_read" ON "public"."projects" FOR SELECT USING (("is_published" = true));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."whoami"() TO "anon";
GRANT ALL ON FUNCTION "public"."whoami"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."whoami"() TO "service_role";


















GRANT ALL ON TABLE "public"."authors" TO "anon";
GRANT ALL ON TABLE "public"."authors" TO "authenticated";
GRANT ALL ON TABLE "public"."authors" TO "service_role";



GRANT ALL ON SEQUENCE "public"."authors_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."authors_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."authors_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."features" TO "anon";
GRANT ALL ON TABLE "public"."features" TO "authenticated";
GRANT ALL ON TABLE "public"."features" TO "service_role";



GRANT ALL ON SEQUENCE "public"."features_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."features_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."features_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."media_assets" TO "anon";
GRANT ALL ON TABLE "public"."media_assets" TO "authenticated";
GRANT ALL ON TABLE "public"."media_assets" TO "service_role";



GRANT ALL ON SEQUENCE "public"."media_assets_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."media_assets_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."media_assets_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."phenomena" TO "anon";
GRANT ALL ON TABLE "public"."phenomena" TO "authenticated";
GRANT ALL ON TABLE "public"."phenomena" TO "service_role";



GRANT ALL ON SEQUENCE "public"."phenomena_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."phenomena_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."phenomena_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."phenomenon_style" TO "anon";
GRANT ALL ON TABLE "public"."phenomenon_style" TO "authenticated";
GRANT ALL ON TABLE "public"."phenomenon_style" TO "service_role";



GRANT ALL ON TABLE "public"."project_author" TO "anon";
GRANT ALL ON TABLE "public"."project_author" TO "authenticated";
GRANT ALL ON TABLE "public"."project_author" TO "service_role";



GRANT ALL ON TABLE "public"."project_feature" TO "anon";
GRANT ALL ON TABLE "public"."project_feature" TO "authenticated";
GRANT ALL ON TABLE "public"."project_feature" TO "service_role";



GRANT ALL ON TABLE "public"."project_media" TO "anon";
GRANT ALL ON TABLE "public"."project_media" TO "authenticated";
GRANT ALL ON TABLE "public"."project_media" TO "service_role";



GRANT ALL ON TABLE "public"."project_style" TO "anon";
GRANT ALL ON TABLE "public"."project_style" TO "authenticated";
GRANT ALL ON TABLE "public"."project_style" TO "service_role";



GRANT ALL ON TABLE "public"."projects" TO "anon";
GRANT ALL ON TABLE "public"."projects" TO "authenticated";
GRANT ALL ON TABLE "public"."projects" TO "service_role";



GRANT ALL ON SEQUENCE "public"."projects_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."projects_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."projects_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."reference_author" TO "anon";
GRANT ALL ON TABLE "public"."reference_author" TO "authenticated";
GRANT ALL ON TABLE "public"."reference_author" TO "service_role";



GRANT ALL ON TABLE "public"."reference_entries" TO "anon";
GRANT ALL ON TABLE "public"."reference_entries" TO "authenticated";
GRANT ALL ON TABLE "public"."reference_entries" TO "service_role";



GRANT ALL ON SEQUENCE "public"."reference_entries_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."reference_entries_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."reference_entries_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."style_reference" TO "anon";
GRANT ALL ON TABLE "public"."style_reference" TO "authenticated";
GRANT ALL ON TABLE "public"."style_reference" TO "service_role";



GRANT ALL ON TABLE "public"."styles" TO "anon";
GRANT ALL ON TABLE "public"."styles" TO "authenticated";
GRANT ALL ON TABLE "public"."styles" TO "service_role";



GRANT ALL ON SEQUENCE "public"."styles_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."styles_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."styles_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."v_project_card_published" TO "anon";
GRANT ALL ON TABLE "public"."v_project_card_published" TO "authenticated";
GRANT ALL ON TABLE "public"."v_project_card_published" TO "service_role";



GRANT ALL ON TABLE "public"."v_style_card_published" TO "anon";
GRANT ALL ON TABLE "public"."v_style_card_published" TO "authenticated";
GRANT ALL ON TABLE "public"."v_style_card_published" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































drop extension if exists "pg_net";


  create policy "DELETE 1mnl3fw_0"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using ((bucket_id = 'project-images'::text));



  create policy "INSERT 1mnl3fw_0"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check ((bucket_id = 'project-images'::text));



  create policy "UPDATE 1mnl3fw_0"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using ((bucket_id = 'project-images'::text))
with check ((bucket_id = 'project-images'::text));


-- deleted

-- deleted

-- deleted

-- deleted

-- deleted


