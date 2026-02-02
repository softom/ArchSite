SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict 4CbdiaHbPno1JIUVJT25GmhKcT5tev7V0Jqu7RpGkVdT5UTxAJgDrFuXKiUcgCn

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."authors" ("id", "slug", "full_name", "birth_year", "death_year", "wiki_url", "bio_short", "is_published", "created_at", "updated_at", "entity_type", "website_url") VALUES
	(1, 'otto-wagner', 'Otto Wagner', 1841, 1918, 'https://en.wikipedia.org/wiki/Otto_Wagner', 'Viennese architect; ╨║╨╗╤О╤З╨╡╨▓╨░╤П ╤Д╨╕╨│╤Г╤А╨░ ╨┐╨╡╤А╨╡╤Е╨╛╨┤╨░ ╨║ ╤Б╨╛╨▓╤А╨╡╨╝╨╡╨╜╨╜╨╛╨╣ ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨╡.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(2, 'louis-sullivan', 'Louis Sullivan', 1856, 1924, 'https://en.wikipedia.org/wiki/Louis_Sullivan', 'American architect; ╤Д╨╛╤А╨╝╤Г╨╗╨░ form follows function.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(3, 'adolf-loos', 'Adolf Loos', 1870, 1933, 'https://en.wikipedia.org/wiki/Adolf_Loos', 'Austrian architect; Ornament und Verbrechen.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(4, 'walter-gropius', 'Walter Gropius', 1883, 1969, 'https://en.wikipedia.org/wiki/Walter_Gropius', 'Founder of the Bauhaus.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(5, 'alexei-gan', 'Aleksei Gan', 1893, 1942, 'https://en.wikipedia.org/wiki/Aleksei_Gan', 'Soviet theorist; ╤В╨╡╨║╤Б╤В ''╨Ъ╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╨╖╨╝'' (1922).', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(6, 'le-corbusier', 'Le Corbusier', 1887, 1965, 'https://en.wikipedia.org/wiki/Le_Corbusier', 'Swiss-French architect; Modernism canon.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(7, 'ludwig-mies-van-der-rohe', 'Ludwig Mies van der Rohe', 1886, 1969, 'https://en.wikipedia.org/wiki/Ludwig_Mies_van_der_Rohe', 'German-American architect; International Style.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(8, 'reyner-banham', 'Reyner Banham', 1922, 1988, 'https://en.wikipedia.org/wiki/Reyner_Banham', 'Historian/critic; New Brutalism.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(9, 'cedric-price', 'Cedric Price', 1934, 2003, 'https://en.wikipedia.org/wiki/Cedric_Price', 'Architect; ╤В╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨┤╨╕╤Б╨║╤Г╤А╤Б 1960-╤Е.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(10, 'robert-venturi', 'Robert Venturi', 1925, 2018, 'https://en.wikipedia.org/wiki/Robert_Venturi', 'Architect; ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨░╤П ╤В╨╡╨╛╤А╨╕╤П.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(11, 'charles-jencks', 'Charles Jencks', 1939, 2019, 'https://en.wikipedia.org/wiki/Charles_Jencks', 'Theorist; ''Language of Post-Modern Architecture''.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(12, 'mark-wigley', 'Mark Wigley', 1956, NULL, 'https://en.wikipedia.org/wiki/Mark_Wigley', 'Academic; MoMA 1988 (Deconstructivist Architecture).', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(13, 'john-pawson', 'John Pawson', 1949, NULL, 'https://en.wikipedia.org/wiki/John_Pawson', 'Minimalist architecture; ''Minimum''.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(14, 'dieter-rams', 'Dieter Rams', 1932, NULL, 'https://en.wikipedia.org/wiki/Dieter_Rams', 'Industrial designer; ''Weniger, aber besser''.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(15, 'patrik-schumacher', 'Patrik Schumacher', 1961, NULL, 'https://en.wikipedia.org/wiki/Patrik_Schumacher', 'Theorist; Parametricism.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL),
	(16, 'bjarke-ingels', 'Bjarke Ingels', 1974, NULL, 'https://en.wikipedia.org/wiki/Bjarke_Ingels', 'Architect; BIG; ''Yes Is More''.', true, '2025-12-12 22:58:02.030956+00', '2025-12-12 22:58:02.030956+00', 'person', NULL);


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."features" ("id", "slug", "title_ru", "title_en", "description", "sort_order", "is_published", "created_at", "updated_at") VALUES
	(1, '', '╨Я╨░╤А╨░╨╝╨╡╤В╤А╨╕╤З╨╡╤Б╨║╨╕╨╡ ╤Н╨╗╨╡╨╝╨╡╨╜╤В╤Л', NULL, NULL, 0, true, '2025-12-13 02:03:33.393709+00', '2025-12-13 02:03:33.393709+00');


--
-- Data for Name: media_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."media_assets" ("id", "slug", "storage_bucket", "storage_path", "public_url", "mime_type", "width", "height", "caption_ru", "caption_original", "credit", "source_url", "license", "created_at", "updated_at", "kind", "description_ru", "is_published") VALUES
	(1, NULL, 'project-images', 'projects/3/1765592387405_0_looshaus-michaelerplatz.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/3/1765592387405_0_looshaus-michaelerplatz.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'Wikipedia', NULL, NULL, '2025-12-13 02:19:48.865771+00', '2025-12-13 02:19:48.865771+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(2, NULL, 'project-images', 'projects/9/1765594361431_0_watercube-night.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/9/1765594361431_0_watercube-night.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'Wikipedia', NULL, NULL, '2025-12-13 02:52:42.524869+00', '2025-12-13 02:52:42.524869+00', 'photo', '╨Э╨╛╤З╨╜╨╛╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(3, NULL, 'project-images', 'projects/16/1765596570594_0_2a303143e3756e2acdbc4cc013ad10d2.png', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/16/1765596570594_0_2a303143e3756e2acdbc4cc013ad10d2.png', 'image/png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 03:29:31.955622+00', '2025-12-13 03:29:31.955622+00', 'photo', NULL, true),
	(4, NULL, 'project-images', 'projects/16/1765596608106_0_e36addb680a3e1604d5950ad1aa9c8d7.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/16/1765596608106_0_e36addb680a3e1604d5950ad1aa9c8d7.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 03:30:09.049909+00', '2025-12-13 03:30:09.049909+00', 'drawing', '╨Я╨╗╨░╨╜', true),
	(5, NULL, 'project-images', 'projects/16/1765596632526_0_maxresdefault.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/16/1765596632526_0_maxresdefault.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 03:30:33.650311+00', '2025-12-13 03:30:33.650311+00', 'photo', '╨Ю╨▒╤Й╨╕╨╣ ╨▓╨╕╨┤', true),
	(6, NULL, 'project-images', 'projects/16/1765596654067_0_200801-os-n1514.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/16/1765596654067_0_200801-os-n1514.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 03:30:55.324176+00', '2025-12-13 03:30:55.324176+00', 'photo', '╨н╨╗╨╡╨╝╨╡╨╜╤В╤Л ╤Д╨░╤Б╨░╨┤╨░', true),
	(7, NULL, 'project-images', 'projects/16/1765596674139_0_200801-os-n379.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/16/1765596674139_0_200801-os-n379.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 03:31:15.357949+00', '2025-12-13 03:31:15.357949+00', 'photo', '╨н╤В╨░╨┐╤Л ╤Б╤В╤А╨╛╨╕╤В╨╡╨╗╤М╤Б╤В╨▓╨░', true),
	(8, NULL, 'project-images', 'projects/18/1765658829229_0_1.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765658829229_0_1.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 20:47:18.653073+00', '2025-12-13 20:47:18.653073+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(9, NULL, 'project-images', 'projects/18/1765658841171_0_4.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765658841171_0_4.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 20:47:27.169776+00', '2025-12-13 20:47:27.169776+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(10, NULL, 'project-images', 'projects/18/1765659575914_0_4.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765659575914_0_4.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 20:59:38.067177+00', '2025-12-13 20:59:38.067177+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(11, NULL, 'project-images', 'projects/18/1765661564898_0_4.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765661564898_0_4.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-13 21:32:46.733219+00', '2025-12-13 21:32:46.733219+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(12, NULL, 'project-images', 'projects/18/1765668721241_0_1.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668721241_0_1.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:32:03.237574+00', '2025-12-13 23:32:03.237574+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(13, NULL, 'project-images', 'projects/18/1765668731561_0_4.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668731561_0_4.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:32:13.106136+00', '2025-12-13 23:32:13.106136+00', 'photo', '╨У╨╗╨░╨▓╨╜╤Л╨╣ ╤Д╨░╤Б╨░╨┤', true),
	(14, NULL, 'project-images', 'projects/18/1765668743789_0_10.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668743789_0_10.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:32:25.636363+00', '2025-12-13 23:32:25.636363+00', 'photo', '╨Ш╨╜╤В╨╡╤А╤М╨╡╤А╤Л', true),
	(15, NULL, 'project-images', 'projects/18/1765668751403_0_11.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668751403_0_11.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:32:33.147254+00', '2025-12-13 23:32:33.147254+00', 'photo', '╨Ш╨╜╤В╨╡╤А╤М╨╡╤А╤Л', true),
	(16, NULL, 'project-images', 'projects/18/1765668758453_0_12.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668758453_0_12.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:32:39.813421+00', '2025-12-13 23:32:39.813421+00', 'photo', '╨Ш╨╜╤В╨╡╤А╤М╨╡╤А╤Л', true),
	(17, NULL, 'project-images', 'projects/18/1765668776087_0_facade.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668776087_0_facade.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:32:57.122276+00', '2025-12-13 23:32:57.122276+00', 'drawing', '╨д╨░╤Б╨░╨┤╤Л', true),
	(18, NULL, 'project-images', 'projects/18/1765668794649_0_first-floor-plan.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668794649_0_first-floor-plan.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:33:15.715856+00', '2025-12-13 23:33:15.715856+00', 'drawing', '╨Я╨╗╨░╨╜ ╨┐╨╡╤А╨▓╨╛╨│╨╛ ╤Н╤В╨░╨╢╨░', true),
	(19, NULL, 'project-images', 'projects/18/1765668809261_0_ground-floor-plan.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668809261_0_ground-floor-plan.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:33:30.361487+00', '2025-12-13 23:33:30.361487+00', 'drawing', '╨Я╨╗╨░╨╜ ╨┐╨╛╨┤╨▓╨░╨╗╤М╨╜╨╛╨│╨╛ ╤Н╤В╨░╨╢╨░', true),
	(20, NULL, 'project-images', 'projects/18/1765668820534_0_second-floor-plan.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668820534_0_second-floor-plan.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:33:41.590651+00', '2025-12-13 23:33:41.590651+00', 'drawing', '╨Я╨╗╨░╨╜ ╨▓╤В╨╛╤А╨╛╨│╨╛ ╤Н╤В╨░╨╢╨░', true),
	(21, NULL, 'project-images', 'projects/18/1765668835777_0_site.jpg', 'https://huvpoyjfdernofmatsuq.supabase.co/storage/v1/object/public/project-images/projects/18/1765668835777_0_site.jpg', 'image/jpeg', NULL, NULL, NULL, NULL, 'archdaily.com', NULL, NULL, '2025-12-13 23:33:57.092883+00', '2025-12-13 23:33:57.092883+00', 'drawing', '╨У╨╡╨╜╨┐╨╗╨░╨╜', true);


--
-- Data for Name: phenomena; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."phenomena" ("id", "slug", "title_ru", "title_en", "date_start_year", "date_end_year", "short_definition", "color", "sort_order", "is_published", "created_at", "updated_at", "image_media_id") VALUES
	(1, 'fin-de-siecle', '╨а╤Г╨▒╨╡╨╢ ╨▓╨╡╨║╨╛╨▓: ╨Ь╨╛╨┤╨╡╤А╨╜ + ╨┐╤А╨╡╨┤╨┐╨╛╤Б╤Л╨╗╨║╨╕ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░', 'Fin de si├иcle: Art Nouveau + Pre-Modernist Foundations', 1890, 1914, '╨Я╨╡╤А╨╡╤Е╨╛╨┤ ╨╛╤В ╨╕╤Б╤В╨╛╤А╨╕╨╖╨╝╨░ ╨║ ╤Б╨╛╨▓╤А╨╡╨╝╨╡╨╜╨╜╨╛╤Б╤В╨╕: ╨╝╨╛╨┤╨╡╤А╨╜, ╤А╨░╨╜╨╜╨╕╨╣ ╤Д╤Г╨╜╨║╤Ж╨╕╨╛╨╜╨░╨╗╨╕╨╖╨╝, ╨║╤А╨╕╤В╨╕╨║╨░ ╨╛╤А╨╜╨░╨╝╨╡╨╜╤В╨░.', '#7A3EFF', 10, true, '2025-12-12 22:58:01.493883+00', '2025-12-12 22:58:01.493883+00', NULL),
	(2, 'modernism', '╨Ь╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝', 'Modernism', 1919, 1975, '╨а╨░╤Ж╨╕╨╛╨╜╨░╨╗╤М╨╜╤Л╨╣ ╨┐╤А╨╛╨╡╨║╤В: ╤Д╤Г╨╜╨║╤Ж╨╕╤П, ╨╕╨╜╨┤╤Г╤Б╤В╤А╨╕╤П, ╤Г╨╜╨╕╨▓╨╡╤А╤Б╨░╨╗╤М╨╜╤Л╨╣ ╤П╨╖╤Л╨║ ╤Д╨╛╤А╨╝╤Л, ╤В╨╕╨┐╨╕╨╖╨░╤Ж╨╕╤П.', '#2F6FED', 20, true, '2025-12-12 22:58:01.493883+00', '2025-12-12 22:58:01.493883+00', NULL),
	(3, 'postmodernism', '╨Я╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝', 'Postmodernism', 1966, 1995, '╨Ъ╤А╨╕╤В╨╕╨║╨░ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨╛╨╣ ╨╛╤А╤В╨╛╨┤╨╛╨║╤Б╨╕╨╕: ╨╖╨╜╨░╨║, ╤Ж╨╕╤В╨░╤В╨░, ╨║╨╛╨╜╤В╨╡╨║╤Б╤В, ╨┐╨╗╤О╤А╨░╨╗╨╕╨╖╨╝.', '#FF6B2F', 30, true, '2025-12-12 22:58:01.493883+00', '2025-12-12 22:58:01.493883+00', NULL),
	(4, 'after-postmodernism', '╨Я╨╛╤Б╨╗╨╡ ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░', 'After Postmodernism', 1995, NULL, '╨Я╨╛╨╗╨╡ ╤Б╤В╤А╨░╤В╨╡╨│╨╕╨╣: ╨╝╨╕╨╜╨╕╨╝╨░╨╗╨╕╨╖╨╝/╨╜╨╡╨╛╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝, ╨┐╨░╤А╨░╨╝╨╡╤В╤А╨╕╤З╨╡╤Б╨║╨░╤П ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░, ╨╜╨╛╨▓╤Л╨╡ ╨│╨╕╨▒╤А╨╕╨┤╤Л.', '#1F9D7A', 40, true, '2025-12-12 22:58:01.493883+00', '2025-12-12 22:58:01.493883+00', NULL);


--
-- Data for Name: styles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."styles" ("id", "slug", "title_ru", "title_en", "date_start_year", "date_end_year", "one_liner", "description", "is_published", "created_at", "updated_at", "color", "image_media_id") VALUES
	(1, 'art-nouveau', '╨Ь╨╛╨┤╨╡╤А╨╜', 'Art Nouveau / Jugendstil', 1890, 1914, '╨Ю╤А╨│╨░╨╜╨╕╤З╨╡╤Б╨║╨░╤П ╨╗╨╕╨╜╨╕╤П, ╨╛╤А╨╜╨░╨╝╨╡╨╜╤В ╨║╨░╨║ ╤Б╨╕╤Б╤В╨╡╨╝╨░, ╤Б╨╕╨╜╤В╨╡╨╖ ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓.', '╨б╤В╨╕╨╗╤М ╤А╤Г╨▒╨╡╨╢╨░ XIXтАУXX ╨▓╨▓.: ╤В╨╛╤В╨░╨╗╤М╨╜╤Л╨╣ ╨┤╨╕╨╖╨░╨╣╨╜, ╤Ж╨╡╨╗╤М╨╜╨░╤П ╤Е╤Г╨┤╨╛╨╢╨╡╤Б╤В╨▓╨╡╨╜╨╜╨░╤П ╤Б╤А╨╡╨┤╨░.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(2, 'early-functionalism', '╨а╨░╨╜╨╜╨╕╨╣ ╤Д╤Г╨╜╨║╤Ж╨╕╨╛╨╜╨░╨╗╨╕╨╖╨╝', 'Early Functionalism', 1896, 1915, '╨д╤Г╨╜╨║╤Ж╨╕╤П ╨║╨░╨║ ╨│╨╡╨╜╨╡╤А╨░╤В╨╛╤А ╤Д╨╛╤А╨╝╤Л (╤А╨░╨╜╨╜╨╕╨╡ ╤Д╨╛╤А╨╝╤Г╨╗╤Л).', '╨Я╨╡╤А╨╡╤Е╨╛╨┤ ╨║ ╤А╨░╤Ж╨╕╨╛╨╜╨░╨╗╤М╨╜╨╛╨╣ ╨╗╨╛╨│╨╕╨║╨╡ ╤Д╨╛╤А╨╝╤Л ╨┤╨╛ ╨╛╤Д╨╛╤А╨╝╨╗╨╡╨╜╨╕╤П ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░ ╨║╨░╨║ ╨┐╨░╤А╨░╨┤╨╕╨│╨╝╤Л.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(3, 'anti-ornament', '╨Р╨╜╤В╨╕╨╛╤А╨╜╨░╨╝╨╡╨╜╤В / ╤А╨░╤Ж╨╕╨╛╨╜╨░╨╗╨╕╨╖╨╝ (╨Ы╨╛╨╛╤Б)', 'Anti-ornament / Loos', 1908, 1930, '╨Ъ╤А╨╕╤В╨╕╨║╨░ ╨┤╨╡╨║╨╛╤А╨░╤В╨╕╨▓╨╜╨╛╤Б╤В╨╕ ╨╕ ╤Н╤В╨╕╨║╨░ ╤А╨╡╨┤╤Г╨║╤Ж╨╕╨╕.', '╨б╨┤╨▓╨╕╨│ ╨║ ╨░╤Б╨║╨╡╤В╨╕╨║╨╡ ╤Д╨╛╤А╨╝╤Л ╨╕ ╨╛╤В╨║╨░╨╖╤Г ╨╛╤В ╨╛╤А╨╜╨░╨╝╨╡╨╜╤В╨░ ╨║╨░╨║ ╨╜╨╛╤А╨╝╤Л.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(4, 'bauhaus', '╨С╨░╤Г╤Е╨░╤Г╤Б', 'Bauhaus', 1919, 1933, '╨Х╨┤╨╕╨╜╤Б╤В╨▓╨╛ ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓╨░ ╨╕ ╤В╨╡╤Е╨╜╨╕╨║╨╕; ╨┐╤А╨╛╨╡╨║╤В╨╕╤А╨╛╨▓╨░╨╜╨╕╨╡ ╨┤╨╗╤П ╨╕╨╜╨┤╤Г╤Б╤В╤А╨╕╨╕.', '╨и╨║╨╛╨╗╨░ ╨╕ ╨╝╨╡╤В╨╛╨┤: ╤В╨╕╨┐╨╕╨╖╨░╤Ж╨╕╤П, ╤Д╤Г╨╜╨║╤Ж╨╕╨╛╨╜╨░╨╗╨╕╨╖╨╝, ╨┤╨╕╨╖╨░╨╣╨╜ ╨║╨░╨║ ╤Б╨╛╤Ж╨╕╨░╨╗╤М╨╜╤Л╨╣ ╨╕╨╜╤Б╤В╤А╤Г╨╝╨╡╨╜╤В.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(5, 'constructivism', '╨Ъ╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╨╖╨╝ (╨б╨б╨б╨а)', 'Constructivism (USSR)', 1920, 1932, '╨Р╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░ ╨║╨░╨║ ╨╛╤А╨│╨░╨╜╨╕╨╖╨░╤Ж╨╕╤П ╨╢╨╕╨╖╨╜╨╕ ╨╕ ╨┐╤А╨╛╨╕╨╖╨▓╨╛╨┤╤Б╤В╨▓╨░.', '╨Р╨▓╨░╨╜╨│╨░╤А╨┤╨╜╨░╤П ╨▓╨╡╤В╨▓╤М ╤Б ╤Б╨╕╨╗╤М╨╜╨╛╨╣ ╤Б╨╛╤Ж╨╕╨░╨╗╤М╨╜╨╛╨╣ ╨┐╤А╨╛╨│╤А╨░╨╝╨╝╨╛╨╣ ╨╕ ╨╕╨╜╨╢╨╡╨╜╨╡╤А╨╜╨╛╨╣ ╤Н╤Б╤В╨╡╤В╨╕╨║╨╛╨╣.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(6, 'art-deco', '╨Р╤А-╨┤╨╡╨║╨╛', 'Art Deco', 1920, 1939, '╨У╨╡╨╛╨╝╨╡╤В╤А╨╕╤П, ╤А╨╡╨┐╤А╨╡╨╖╨╡╨╜╤В╨░╤В╨╕╨▓╨╜╨╛╤Б╤В╤М, ┬л╤Б╨╛╨▓╤А╨╡╨╝╨╡╨╜╨╜╨░╤П ╤А╨╛╤Б╨║╨╛╤И╤М┬╗.', '╨б╨▓╤П╨╖╤М ╨┤╨╡╨║╨╛╤А╨░╤В╨╕╨▓╨╜╨╛╨│╨╛ ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓╨░ ╨╕ ╨╕╨╜╨┤╤Г╤Б╤В╤А╨╕╨╕ ╨╝╨╡╨╢╨▓╨╛╨╡╨╜╨╜╨╛╨│╨╛ ╨▓╤А╨╡╨╝╨╡╨╜╨╕.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(7, 'international-style', '╨Ш╨╜╤В╨╡╤А╨╜╨░╤Ж╨╕╨╛╨╜╨░╨╗╤М╨╜╤Л╨╣ ╤Б╤В╨╕╨╗╤М / ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝ (╨║╨░╨╜╨╛╨╜)', 'International Style / Canonical Modernism', 1923, 1970, '╨г╨╜╨╕╨▓╨╡╤А╤Б╨░╨╗╤М╨╜╤Л╨╣ ╤П╨╖╤Л╨║ ╤Д╨╛╤А╨╝╤Л, ╤Д╤Г╨╜╨║╤Ж╨╕╨╛╨╜╨░╨╗╨╕╨╖╨╝, ╨╛╤В╨║╨░╨╖ ╨╛╤В ╨╕╤Б╤В╨╛╤А╨╕╤З╨╡╤Б╨║╨╛╨│╨╛ ╨┤╨╡╨║╨╛╤А╨░.', '╨Ъ╨░╨╜╨╛╨╜╨╕╤З╨╡╤Б╨║╨░╤П ╨╗╨╕╨╜╨╕╤П ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░ (╨Ъ╨╛╤А╨▒╤О, ╨Ь╨╕╤Б ╨╕ ╨┤╤А.).', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(8, 'brutalism', '╨С╤А╤Г╤В╨░╨╗╨╕╨╖╨╝', 'Brutalism / New Brutalism', 1950, 1975, '╨н╤В╨╕╨║╨░ ┬л╨║╨░╨║ ╨╡╤Б╤В╤М┬╗: ╨╝╨░╤В╨╡╤А╨╕╨░╨╗, ╨║╨╛╨╜╤Б╤В╤А╤Г╨║╤Ж╨╕╤П, ╤Д╨░╨║╤В╤Г╤А╨░.', '╨Я╨╛╨╖╨┤╨╜╨╡╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨░╤П ╨▓╨╡╤В╨▓╤М; ╤В╨╡╨╖╨╕╤Б ┬л╤Н╤В╨╕╨║╨░, ╨░ ╨╜╨╡ ╤Н╤Б╤В╨╡╤В╨╕╨║╨░┬╗.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(9, 'high-tech', '╨е╨░╨╣-╤В╨╡╨║', 'High-Tech', 1970, 1995, '╨Ш╨╜╨╢╨╡╨╜╨╡╤А╨╕╤П ╨║╨░╨║ ╤Н╤Б╤В╨╡╤В╨╕╨║╨░; ╤Н╨║╤Б╨┐╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╡ ╨╕╨╜╤Д╤А╨░╤Б╤В╤А╤Г╨║╤В╤Г╤А╤Л.', '╨в╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╤З╨╡╤Б╨║╨░╤П ╤Н╨║╤Б╨┐╤А╨╡╤Б╤Б╨╕╨▓╨╜╨╛╤Б╤В╤М ╨╕ ╨┤╨╡╨╝╨╛╨╜╤Б╤В╤А╨░╤Ж╨╕╤П ╤Б╨╕╤Б╤В╨╡╨╝.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(10, 'postmodern-architecture', '╨Я╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝ (╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░)', 'Postmodern Architecture', 1966, 1995, '╨ж╨╕╤В╨░╤В╨░, ╨╖╨╜╨░╨║, ╨║╨╛╨╜╤В╨╡╨║╤Б╤В; ╨╛╤В╨║╨░╨╖ ╨╛╤В ╨╡╨┤╨╕╨╜╨╛╨│╨╛ ╨║╨░╨╜╨╛╨╜╨░.', '╨Р╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨╜╤Л╨╣ ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝ ╨╛╤В ╨Т╨╡╨╜╤В╤Г╤А╨╕ ╨┤╨╛ 1980-╤Е.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(11, 'deconstructivism', '╨Ф╨╡╨║╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╨╖╨╝', 'Deconstructivism', 1988, 2005, '╨д╤А╨░╨│╨╝╨╡╨╜╤В╨░╤Ж╨╕╤П ╨╕ ╨║╨╛╨╜╤Д╨╗╨╕╨║╤В ╨│╨╡╨╛╨╝╨╡╤В╤А╨╕╨╣; ┬л╨╜╨╡╤Г╤Б╤В╨╛╨╣╤З╨╕╨▓╨╛╤Б╤В╤М┬╗ ╤Д╨╛╤А╨╝╤Л.', '╨Т╨╛╨╗╨╜╨░ ╨║╨╛╨╜╤Ж╨░ XX ╨▓╨╡╨║╨░, ╨╖╨░╨║╤А╨╡╨┐╨╗╤С╨╜╨╜╨░╤П ╨▓╤Л╤Б╤В╨░╨▓╨║╨╛╨╣ MoMA 1988.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(12, 'neomodernism-minimalism', '╨Э╨╡╨╛╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝ / ╨╝╨╕╨╜╨╕╨╝╨░╨╗╨╕╨╖╨╝', 'Neomodernism / Minimalism', 1995, 2015, '╨Т╨╛╨╖╨▓╤А╨░╤В ╨║ ╤П╤Б╨╜╨╛╤Б╤В╨╕ ╨╕ ╤А╨╡╨┤╤Г╨║╤Ж╨╕╨╕; ┬л╤В╨╕╤И╨╕╨╜╨░┬╗ ╨┤╨╡╤В╨░╨╗╨╡╨╣.', '╨Ф╨╕╤Б╤Ж╨╕╨┐╨╗╨╕╨╜╨░ ╤Д╨╛╤А╨╝╤Л, ╤Б╨▓╨╡╤В╨░ ╨╕ ╨╝╨░╤В╨╡╤А╨╕╨░╨╗╨░.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(13, 'parametricism', '╨Я╨░╤А╨░╨╝╨╡╤В╤А╨╕╤Ж╨╕╨╖╨╝', 'Parametricism', 2008, NULL, '╨ж╨╕╤Д╤А╨╛╨▓╨╛╨╡ ╤Д╨╛╤А╨╝╨╛╨╛╨▒╤А╨░╨╖╨╛╨▓╨░╨╜╨╕╨╡, ╨╜╨╡╨┐╤А╨╡╤А╤Л╨▓╨╜╤Л╨╡ ╨┐╨╛╨╗╤П, ╨┐╨░╤А╨░╨╝╨╡╤В╤А╨╕╤З╨╡╤Б╨║╨╕╨╡ ╨║╨╛╤А╤А╨╡╨╗╤П╤Ж╨╕╨╕.', '╨Ь╨░╨╜╨╕╤Д╨╡╤Б╤В╨╜╨░╤П ╨┐╤А╨╡╤В╨╡╨╜╨╖╨╕╤П ╨╜╨░ ┬л╨╜╨╛╨▓╤Л╨╣ ╤Б╤В╨╕╨╗╤М┬╗ ╨┐╨╛╤Б╨╗╨╡ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL),
	(14, 'post-postmodernism', '╨Я╨╛╤Б╤В-╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜ / ╨╜╨╡╨╛-╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜ (╨┐╨╛╨╗╨╡)', 'Post-postmodern / Neo-postmodern (field)', 2009, NULL, '╨а╨╡╨╝╨╕╨║╤Б ╤Б╤В╤А╨░╤В╨╡╨│╨╕╨╣: ╨╕╤А╨╛╨╜╨╕╤П+╨╕╤Б╨║╤А╨╡╨╜╨╜╨╛╤Б╤В╤М, ┬л╨╕ ╤В╨╛, ╨╕ ╨┤╤А╤Г╨│╨╛╨╡┬╗.', '╨и╨╕╤А╨╛╨║╨╛╨╡ ╤Б╨╛╤Б╤В╨╛╤П╨╜╨╕╨╡ ╨║╤Г╨╗╤М╤В╤Г╤А╤Л ╨╕ ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╤Л 2010тАУ2020-╤Е.', true, '2025-12-12 22:58:01.842335+00', '2025-12-12 22:58:01.842335+00', NULL, NULL);


--
-- Data for Name: phenomenon_style; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."phenomenon_style" ("phenomenon_id", "style_id", "is_primary", "sort_order", "note") VALUES
	(1, 1, true, 10, NULL),
	(1, 2, true, 20, NULL),
	(1, 3, true, 30, NULL),
	(2, 3, false, 10, '╨Я╨╡╤А╨╡╤Е╨╛╨┤╨╕╤В ╨▓ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╤Г╤О ╤А╨╡╨┤╤Г╨║╤Ж╨╕╤О/╤Н╤В╨╕╨║╤Г.'),
	(2, 4, true, 20, NULL),
	(2, 5, true, 30, NULL),
	(2, 6, true, 40, '╨Я╨░╤А╨░╨╗╨╗╨╡╨╗╤М╨╜╨░╤П ╨╗╨╕╨╜╨╕╤П ╨╝╨╡╨╢╨▓╨╛╨╡╨╜╨╜╨╛╨╣ ╨╝╨╛╨┤╨╡╤А╨╜╨╛╤Б╤В╨╕.'),
	(2, 7, true, 50, NULL),
	(2, 8, true, 60, NULL),
	(2, 9, true, 70, NULL),
	(3, 9, false, 10, '╨б╨╛╤Б╤Г╤Й╨╡╤Б╤В╨▓╤Г╨╡╤В ╨╕ ╤З╨░╤Б╤В╨╕╤З╨╜╨╛ ╨┐╨╡╤А╨╡╤Е╨╛╨┤╨╕╤В ╨▓ ╨┐╨╛╤Б╤ВтАС╨┐╨╛╨╗╨╡.'),
	(3, 10, true, 20, NULL),
	(3, 11, true, 30, NULL),
	(4, 12, true, 10, NULL),
	(2, 12, false, 80, '╨з╨░╤Б╤В╨╛ ╤З╨╕╤В╨░╨╡╤В╤Б╤П ╨║╨░╨║ ╨▓╨╛╨╖╨▓╤А╨░╤Й╨╡╨╜╨╕╨╡/╨┐╤А╨╛╨┤╨╛╨╗╨╢╨╡╨╜╨╕╨╡ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨╛╨╣ ╨┤╨╕╤Б╤Ж╨╕╨┐╨╗╨╕╨╜╤Л.'),
	(4, 13, true, 20, NULL),
	(4, 14, true, 30, NULL);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."projects" ("id", "slug", "title_original", "title_ru", "year_start", "year_end", "city", "country", "typology", "description_short", "wiki_url", "is_published", "created_at", "updated_at", "slogan_original", "slogan_ru", "slogan_language", "slogan_source_url", "lat", "lon", "project_kind") VALUES
	(1, 'oesterreichische-postsparkasse', '├Цsterreichische Postsparkasse', '╨Р╨▓╤Б╤В╤А╨╕╨╣╤Б╨║╨╕╨╣ ╨┐╨╛╤З╤В╨╛╨▓╤Л╨╣ ╤Б╨▒╨╡╤А╨╡╨│╨░╤В╨╡╨╗╤М╨╜╤Л╨╣ ╨▒╨░╨╜╨║ (╨Я╨╛╤З╤В╨╛╨▓╨░╤П ╤Б╨▒╨╡╤А╨║╨░╤Б╤Б╨░)', 1904, 1906, 'Vienna', 'Austria', 'office/bank', '╨Ъ╨╗╤О╤З╨╡╨▓╨╛╨╣ ╨╛╨▒╤К╨╡╨║╤В ╨▓╨╡╨╜╤Б╨║╨╛╨╣ ╨╗╨╕╨╜╨╕╨╕ ╤А╨░╨╜╨╜╨╡╨╣ ╨╝╨╛╨┤╨╡╤А╨╜╨╛╤Б╤В╨╕.', 'https://en.wikipedia.org/wiki/Postal_Savings_Bank_(Vienna)', true, '2025-12-12 22:58:02.530742+00', '2025-12-12 22:58:02.530742+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(2, 'wainwright-building', 'Wainwright Building', '╨Ч╨┤╨░╨╜╨╕╨╡ ╨г╤Н╨╣╨╜╤А╨░╨╣╤В', 1890, 1891, 'St. Louis', 'USA', 'office', '╨а╨░╨╜╨╜╤П╤П ╨▓╤Л╤Б╨╛╤В╨╜╨░╤П ╤В╨╕╨┐╨╛╨╗╨╛╨│╨╕╤П; ╨║╨╛╨╜╤В╨╡╨║╤Б╤В ╨б╨░╨╗╨╗╨╕╨▓╨░╨╜╨░.', 'https://en.wikipedia.org/wiki/Wainwright_Building', true, '2025-12-12 22:58:02.530742+00', '2025-12-12 22:58:02.530742+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(4, 'bauhaus-dessau', 'Bauhaus Dessau', '╨С╨░╤Г╤Е╨░╤Г╤Б ╨▓ ╨Ф╨╡╤Б╤Б╨░╤Г', 1925, 1926, 'Dessau', 'Germany', 'school', '╨Ш╨║╨╛╨╜╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨╛╨▒╤К╨╡╨║╤В ╨С╨░╤Г╤Е╨░╤Г╤Б╨░ ╨╕ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░.', 'https://en.wikipedia.org/wiki/Bauhaus_Dessau', true, '2025-12-12 22:58:02.530742+00', '2025-12-12 22:58:02.530742+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(5, 'villa-savoye', 'Villa Savoye', '╨Т╨╕╨╗╨╗╨░ ╨б╨░╨▓╨╛╨╣', 1928, 1931, 'Poissy', 'France', 'house', '╨Ъ╨░╨╜╨╛╨╜╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨╛╨▒╤К╨╡╨║╤В ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░ (╨Ъ╨╛╤А╨▒╤О).', 'https://en.wikipedia.org/wiki/Villa_Savoye', true, '2025-12-12 22:58:02.530742+00', '2025-12-12 22:58:02.530742+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(6, 'unite-dhabitation-marseille', 'Unit├й d''Habitation (Marseille)', '╨Ц╨╕╨╗╨░╤П ╨╡╨┤╨╕╨╜╨╕╤Ж╨░ (╨Ь╨░╤А╤Б╨╡╨╗╤М)', 1947, 1952, 'Marseille', 'France', 'housing', '╨Ю╨┤╨╕╨╜ ╨╕╨╖ ╨║╨╗╤О╤З╨╡╨▓╤Л╤Е ╨╛╨▒╤К╨╡╨║╤В╨╛╨▓ ╨┐╨╛╤Б╨╗╨╡╨▓╨╛╨╡╨╜╨╜╨╛╨│╨╛ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░; ╨▓╨░╨╢╨╡╨╜ ╨┤╨╗╤П ╨┤╨╕╤Б╨║╤Г╤А╤Б╨░ ╨▒╤А╤Г╤В╨░╨╗╨╕╨╖╨╝╨░.', 'https://en.wikipedia.org/wiki/Unit├й_d%27habitation', true, '2025-12-12 22:58:02.530742+00', '2025-12-12 22:58:02.530742+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(7, '8-house', '8 House (8Tallet)', '8 House (8Tallet)', 2006, 2010, 'Copenhagen', 'Denmark', 'housing/mixed-use', '╨Я╤А╨╕╨╝╨╡╤А ╨┐╨╛╤Б╤ВтАС╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨╛╨╣ ╨╗╨╛╨│╨╕╨║╨╕ ╨│╨╕╨▒╤А╨╕╨┤╨╜╨╛╤Б╤В╨╕ ╨╕ ╨┐╤А╨░╨│╨╝╨░╤В╨╕╨║╨╕.', 'https://en.wikipedia.org/wiki/8_House', true, '2025-12-12 22:58:02.530742+00', '2025-12-12 22:58:02.530742+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(3, 'looshaus', 'Looshaus', '╨Ф╨╛╨╝ ╨Ы╨╛╨╛╤Б╨░ (Looshaus)', 1910, 1911, 'Vienna', 'Austria', 'mixed-use', '╨а╨░╨┤╨╕╨║╨░╨╗╤М╨╜╨░╤П ╤А╨╡╨┤╤Г╨║╤Ж╨╕╤П ╨╕ ╨║╨╛╨╜╤Д╨╗╨╕╨║╤В ╤Б ╨┤╨╡╨║╨╛╤А╨░╤В╨╕╨▓╨╜╤Л╨╝╨╕ ╨╛╨╢╨╕╨┤╨░╨╜╨╕╤П╨╝╨╕ ╤Н╨┐╨╛╤Е╨╕.', 'https://en.wikipedia.org/wiki/Looshaus', true, '2025-12-12 22:58:02.530742+00', '2025-12-13 02:53:57.096011+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(9, 'water-cube', 'Water Cube', '╨Я╨╡╨║╨╕╨╜╤Б╨║╨╕╨╣ ╨╜╨░╤Ж╨╕╨╛╨╜╨░╨╗╤М╨╜╤Л╨╣ ╨┐╨╗╨░╨▓╨░╤В╨╡╨╗╤М╨╜╤Л╨╣ ╨║╨╛╨╝╨┐╨╗╨╡╨║╤Б', NULL, 2008, '╨з╨░╨╛╤П╨╜ (╨Я╨╡╨║╨╕╨╜)', '╨Ъ╨╕╤В╨░╨╣', '╤Б╨┐╨╛╤А╤В╨╕╨▓╨╜╨╛╨╡, ╨╛╨▒╤Й╨╡╤Б╤В╨▓╨╡╨╜╨╜╨╛╨╡ ╤Б╨╛ ╨╖╤А╨╡╨╗╨╕╤Й╨╜╨╛╨╣ ╤Д╤Г╨╜╨║╤Ж╨╕╨╡╨╣', NULL, 'https://ru.wikipedia.org/wiki/╨Я╨╡╨║╨╕╨╜╤Б╨║╨╕╨╣_╨╜╨░╤Ж╨╕╨╛╨╜╨░╨╗╤М╨╜╤Л╨╣_╨┐╨╗╨░╨▓╨░╤В╨╡╨╗╤М╨╜╤Л╨╣_╨║╨╛╨╝╨┐╨╗╨╡╨║╤Б', true, '2025-12-13 02:30:06.138894+00', '2025-12-13 03:23:36.139256+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(16, 'king-abdulaziz-center-for-world-culture', 'King Abdulaziz Center for World Culture', 'King Abdulaziz Center for World Culture', NULL, 2016, NULL, NULL, NULL, NULL, 'https://en.wikipedia.org/wiki/King_Abdulaziz_Center_for_World_Culture', true, '2025-12-13 03:29:19.876339+00', '2025-12-13 03:31:36.052902+00', NULL, NULL, NULL, NULL, NULL, NULL, 'architecture_object'),
	(18, 'delta-tielt', 'DELTA - Tielt', '╨Я╤А╨╛╨╡╨║╤В ╨Ф╨╡╨╗╤М╤В╨░ ╨▓ ╨в╨╕╨╗╤В╨╡', NULL, 2016, '╨в╨╕╨╗╤В', '╨С╨╡╨╗╤М╨│╨╕╤П', '╨Ю╤Д╨╕╤Б╨╜╨╛╨╡ ╨╖╨┤╨░╨╜╨╕╨╡', NULL, 'https://www.archdaily.com/office/de-jaeghere-architectuuratelier?ad_name=project-specs&ad_medium=single', true, '2025-12-13 20:47:09.058431+00', '2025-12-13 23:44:30.26171+00', NULL, NULL, NULL, NULL, 50.9993, 3.3271, 'architecture_object');


--
-- Data for Name: project_author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."project_author" ("project_id", "author_id", "role") VALUES
	(1, 1, 'architect'),
	(2, 2, 'architect'),
	(3, 3, 'architect'),
	(4, 4, 'architect'),
	(5, 6, 'architect'),
	(6, 6, 'architect'),
	(7, 16, 'architect');


--
-- Data for Name: project_feature; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."project_feature" ("project_id", "feature_id", "note") VALUES
	(9, 1, NULL),
	(16, 1, NULL);


--
-- Data for Name: project_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."project_media" ("project_id", "media_id", "sort_order", "is_cover", "note") VALUES
	(9, 2, 10, true, NULL),
	(3, 1, 10, true, NULL),
	(16, 5, 10, true, NULL),
	(16, 6, 20, false, NULL),
	(16, 4, 50, false, NULL),
	(16, 7, 30, false, NULL),
	(16, 3, 40, false, NULL),
	(18, 12, 10, false, NULL),
	(18, 13, 20, false, NULL),
	(18, 14, 30, false, NULL),
	(18, 15, 40, false, NULL),
	(18, 16, 50, false, NULL),
	(18, 17, 60, false, NULL),
	(18, 18, 70, false, NULL),
	(18, 19, 80, false, NULL),
	(18, 20, 90, false, NULL),
	(18, 21, 100, false, NULL);


--
-- Data for Name: project_style; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."project_style" ("project_id", "style_id", "confidence", "note") VALUES
	(1, 1, 'primary', NULL),
	(1, 2, 'secondary', NULL),
	(2, 2, 'primary', NULL),
	(3, 3, 'primary', NULL),
	(4, 4, 'primary', NULL),
	(5, 7, 'primary', NULL),
	(6, 8, 'primary', NULL),
	(6, 7, 'secondary', NULL),
	(7, 14, 'primary', NULL),
	(9, 13, 'primary', NULL),
	(16, 13, 'primary', NULL),
	(18, 12, 'primary', NULL);


--
-- Data for Name: reference_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."reference_entries" ("id", "slug", "kind", "subtype", "title_original", "title_ru", "text_original", "text_ru", "original_language", "year", "href", "reliability", "commentary", "is_published", "created_at", "updated_at") VALUES
	(1, 'secession-motto-1898', 'quote', 'inscription', 'Wiener Secession motto', '╨Ф╨╡╨▓╨╕╨╖ ╨Т╨╡╨╜╤Б╨║╨╛╨│╨╛ ╨б╨╡╤Ж╨╡╤Б╤Б╨╕╨╛╨╜╨░', 'Der Zeit ihre Kunst, der Kunst ihre Freiheit.', '╨Ъ╨░╨╢╨┤╨╛╨╝╤Г ╨▓╤А╨╡╨╝╨╡╨╜╨╕ тАФ ╤Б╨▓╨╛╤С ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓╨╛, ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓╤Г тАФ ╤Б╨▓╨╛╤О ╤Б╨▓╨╛╨▒╨╛╨┤╤Г.', 'de', 1898, 'https://en.wikipedia.org/wiki/Secession_Building', 'solid', '╨Э╨░╨┤╨┐╨╕╤Б╤М ╨╜╨░ ╨╖╨┤╨░╨╜╨╕╨╕ ╨Т╨╡╨╜╤Б╨║╨╛╨│╨╛ ╨б╨╡╤Ж╨╡╤Б╤Б╨╕╨╛╨╜╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(2, 'wagner-moderne-architektur-1896', 'text', 'book', 'Moderne Architektur', '╨б╨╛╨▓╤А╨╡╨╝╨╡╨╜╨╜╨░╤П ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░', NULL, NULL, 'de', 1896, 'https://en.wikipedia.org/wiki/Otto_Wagner', 'solid', '╨в╤А╨░╨┤╨╕╤Ж╨╕╨╛╨╜╨╜╤Л╨╣ ╨╛╨┐╨╛╤А╨╜╤Л╨╣ ╨╕╤Б╤В╨╛╤З╨╜╨╕╨║ ╨┐╨╛ ╨▓╨╡╨╜╤Б╨║╨╛╨╝╤Г ╨┐╨╡╤А╨╡╤Е╨╛╨┤╤Г ╨║ ╨╝╨╛╨┤╨╡╤А╨╜╨╛╤Б╤В╨╕.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(3, 'sullivan-tall-office-building-1896', 'text', 'article', 'The Tall Office Building Artistically Considered', '╨е╤Г╨┤╨╛╨╢╨╡╤Б╤В╨▓╨╡╨╜╨╜╨╛╨╡ ╤А╨░╤Б╤Б╨╝╨╛╤В╤А╨╡╨╜╨╕╨╡ ╨▓╤Л╤Б╨╛╤В╨╜╨╛╨│╨╛ ╨╛╤Д╨╕╤Б╨╜╨╛╨│╨╛ ╨╖╨┤╨░╨╜╨╕╤П', NULL, NULL, 'en', 1896, 'https://en.wikipedia.org/wiki/The_Tall_Office_Building_Artistically_Considered', 'solid', '╨б╤В╨░╤В╤М╤П, ╨│╨┤╨╡ ╤Д╨╛╤А╨╝╤Г╨╗╨╕╤А╤Г╨╡╤В╤Б╤П ╨┐╤А╨╕╨╜╤Ж╨╕╨┐ ╤Д╨╛╤А╨╝╤Л ╨╕ ╤Д╤Г╨╜╨║╤Ж╨╕╨╕.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(4, 'sullivan-form-follows-function-1896', 'quote', 'quote', NULL, NULL, 'form ever follows function', '╤Д╨╛╤А╨╝╨░ ╨▓╤Б╨╡╨│╨┤╨░ ╤Б╨╗╨╡╨┤╤Г╨╡╤В ╤Д╤Г╨╜╨║╤Ж╨╕╨╕', 'en', 1896, 'https://en.wikipedia.org/wiki/Form_follows_function', 'solid', '╨Ъ╨╗╨░╤Б╤Б╨╕╤З╨╡╤Б╨║╨░╤П ╤А╨░╨╜╨╜╤П╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╤Д╤Г╨╜╨║╤Ж╨╕╨╛╨╜╨░╨╗╨╕╨╖╨╝╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(5, 'loos-ornament-und-verbrechen-1908', 'text', 'essay', 'Ornament und Verbrechen', '╨Ю╤А╨╜╨░╨╝╨╡╨╜╤В ╨╕ ╨┐╤А╨╡╤Б╤В╤Г╨┐╨╗╨╡╨╜╨╕╨╡', NULL, NULL, 'de', 1908, 'https://en.wikipedia.org/wiki/Ornament_and_Crime', 'solid', '╨Ъ╨╗╤О╤З╨╡╨▓╨╛╨╣ ╤В╨╡╨║╤Б╤В ╨░╨╜╤В╨╕╨╛╤А╨╜╨░╨╝╨╡╨╜╤В╨░╨╗╤М╨╜╨╛╨│╨╛ ╨┐╨╛╨▓╨╛╤А╨╛╤В╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(6, 'bauhaus-manifesto-1919', 'text', 'manifesto', 'Bauhaus Manifesto', '╨Ь╨░╨╜╨╕╤Д╨╡╤Б╤В ╨С╨░╤Г╤Е╨░╤Г╤Б╨░', NULL, NULL, 'de', 1919, 'https://en.wikipedia.org/wiki/Bauhaus', 'solid', '╨Я╤А╨╛╨│╤А╨░╨╝╨╝╨╜╤Л╨╣ ╤В╨╡╨║╤Б╤В ╨╛╤Б╨╜╨╛╨▓╨░╨╜╨╕╤П ╤И╨║╨╛╨╗╤Л.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(7, 'bauhaus-endziel-ist-der-bau-1919', 'quote', 'quote', NULL, NULL, 'Das Endziel aller bildnerischen T├дtigkeit ist der Bau!', '╨Ъ╨╛╨╜╨╡╤З╨╜╨░╤П ╤Ж╨╡╨╗╤М ╨▓╤Б╤П╨║╨╛╨╣ ╤Е╤Г╨┤╨╛╨╢╨╡╤Б╤В╨▓╨╡╨╜╨╜╨╛╨╣ ╨┤╨╡╤П╤В╨╡╨╗╤М╨╜╨╛╤Б╤В╨╕ тАФ ╤Б╤В╤А╨╛╨╕╤В╨╡╨╗╤М╤Б╤В╨▓╨╛!', 'de', 1919, 'https://en.wikipedia.org/wiki/Bauhaus#Weimar_period', 'solid', '╨ж╨╕╤В╨░╤В╨░ ╨╕╨╖ ╨╝╨░╨╜╨╕╤Д╨╡╤Б╤В╨░ ╨С╨░╤Г╤Е╨░╤Г╤Б╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(8, 'bauhaus-kunst-und-technik-1923', 'quote', 'motto', NULL, NULL, 'Kunst und Technik тАУ eine neue Einheit.', '╨Ш╤Б╨║╤Г╤Б╤Б╤В╨▓╨╛ ╨╕ ╤В╨╡╤Е╨╜╨╕╨║╨░ тАФ ╨╜╨╛╨▓╨╛╨╡ ╨╡╨┤╨╕╨╜╤Б╤В╨▓╨╛.', 'de', 1923, 'https://en.wikipedia.org/wiki/Bauhaus', 'solid', '╨Я╤А╨╛╨│╤А╨░╨╝╨╝╨╜╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╨С╨░╤Г╤Е╨░╤Г╤Б╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(9, 'gan-konstruktivizm-1922', 'text', 'book', '╨Ъ╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╨╖╨╝', '╨Ъ╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╨╖╨╝', NULL, NULL, 'ru', 1922, 'https://en.wikipedia.org/wiki/Aleksei_Gan', 'solid', '╨Ю╨┤╨╕╨╜ ╨╕╨╖ ╨┐╤А╨╛╨│╤А╨░╨╝╨╝╨╜╤Л╤Е ╤В╨╡╨║╤Б╤В╨╛╨▓ ╨║╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╨╖╨╝╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(10, 'exposition-arts-decoratifs-1925', 'text', 'exhibition', 'Exposition internationale des arts d├йcoratifs et industriels modernes (Paris, 1925)', '╨Т╤Л╤Б╤В╨░╨▓╨║╨░ ╤Б╨╛╨▓╤А╨╡╨╝╨╡╨╜╨╜╤Л╤Е ╨┤╨╡╨║╨╛╤А╨░╤В╨╕╨▓╨╜╤Л╤Е ╨╕ ╨┐╤А╨╛╨╝╤Л╤И╨╗╨╡╨╜╨╜╤Л╤Е ╨╕╤Б╨║╤Г╤Б╤Б╤В╨▓ (╨Я╨░╤А╨╕╨╢, 1925)', NULL, NULL, 'fr', 1925, 'https://en.wikipedia.org/wiki/International_Exposition_of_Modern_Decorative_and_Industrial_Arts', 'solid', '╨Э╨░╨╖╨▓╨░╨╜╨╕╨╡ ╨▓╤Л╤Б╤В╨░╨▓╨║╨╕ ╤З╨░╤Б╤В╨╛ ╨▓╤Л╤Б╤В╤Г╨┐╨░╨╡╤В ╨║╨░╨║ ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╨░╤А-╨┤╨╡╨║╨╛.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(11, 'lecorbusier-vers-une-architecture-1923', 'text', 'book', 'Vers une architecture', '╨Ъ ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨╡', NULL, NULL, 'fr', 1923, 'https://en.wikipedia.org/wiki/Towards_a_New_Architecture', 'solid', '╨Ъ╨╗╤О╤З╨╡╨▓╨╛╨╣ ╤В╨╡╨║╤Б╤В ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░ (╨Ъ╨╛╤А╨▒╤О).', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(12, 'lecorbusier-machine-a-habiter-1923', 'quote', 'quote', NULL, NULL, 'Une maison est une machine ├а habiter.', '╨Ф╨╛╨╝ тАФ ╨╝╨░╤И╨╕╨╜╨░ ╨┤╨╗╤П ╨╢╨╕╨╗╤М╤П.', 'fr', 1923, 'https://en.wikipedia.org/wiki/Towards_a_New_Architecture', 'solid', '╨Ю╨┤╨╜╨░ ╨╕╨╖ ╤Б╨░╨╝╤Л╤Е ╤Ж╨╕╤В╨╕╤А╤Г╨╡╨╝╤Л╤Е ╤Д╨╛╤А╨╝╤Г╨╗ ╨Ъ╨╛╤А╨▒╤О.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(13, 'banham-new-brutalism-1966', 'text', 'book', 'The New Brutalism: Ethic or Aesthetic?', '╨Э╨╛╨▓╤Л╨╣ ╨▒╤А╤Г╤В╨░╨╗╨╕╨╖╨╝: ╤Н╤В╨╕╨║╨░ ╨╕╨╗╨╕ ╤Н╤Б╤В╨╡╤В╨╕╨║╨░?', NULL, NULL, 'en', 1966, 'https://en.wikipedia.org/wiki/Reyner_Banham', 'solid', '╨Ъ╨╗╤О╤З╨╡╨▓╨╛╨╣ ╨╕╤Б╤В╨╛╤З╨╜╨╕╨║ ╨┐╨╛ New Brutalism.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(14, 'banham-ethic-not-an-aesthetic-1955', 'quote', 'quote', NULL, NULL, '...an ethic, not an aesthetic.', 'тАж╤Н╤В╨╕╨║╨░, ╨░ ╨╜╨╡ ╤Н╤Б╤В╨╡╤В╨╕╨║╨░.', 'en', 1955, 'https://en.wikipedia.org/wiki/New_Brutalism', 'solid', '╨Ы╨╛╨╖╤Г╨╜╨│╨╛╨▓╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╨▓ ╨┤╨╕╤Б╨║╤Г╤А╤Б╨╡ New Brutalism.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(15, 'price-technology-is-the-answer-1966', 'quote', 'quote', NULL, NULL, 'Technology is the answer, but what was the question?', '╨в╨╡╤Е╨╜╨╛╨╗╨╛╨│╨╕╤П тАФ ╤Н╤В╨╛ ╨╛╤В╨▓╨╡╤В, ╨╜╨╛ ╨║╨░╨║╨╛╨▓ ╨▒╤Л╨╗ ╨▓╨╛╨┐╤А╨╛╤Б?', 'en', 1966, 'https://en.wikipedia.org/wiki/Cedric_Price', 'common_attrib', '╨и╨╕╤А╨╛╨║╨╛ ╤Ж╨╕╤В╨╕╤А╤Г╨╡╤В╤Б╤П ╨║╨░╨║ ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╤В╨╡╤Е╨╜╨╛-╨┐╨╛╨▓╨╛╤А╨╛╤В╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(16, 'venturi-complexity-and-contradiction-1966', 'text', 'book', 'Complexity and Contradiction in Architecture', '╨б╨╗╨╛╨╢╨╜╨╛╤Б╤В╤М ╨╕ ╨┐╤А╨╛╤В╨╕╨▓╨╛╤А╨╡╤З╨╕╨╡ ╨▓ ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨╡', NULL, NULL, 'en', 1966, 'https://en.wikipedia.org/wiki/Complexity_and_Contradiction_in_Architecture', 'solid', '╨Ю╨┤╨╕╨╜ ╨╕╨╖ ╨▒╨░╨╖╨╛╨▓╤Л╤Е ╤В╨╡╨║╤Б╤В╨╛╨▓ ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨╜╨╛╨│╨╛ ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(17, 'venturi-less-is-a-bore', 'quote', 'quote', NULL, NULL, 'Less is a bore.', '┬л╨Ь╨╡╨╜╤М╤И╨╡┬╗ тАФ ╤Н╤В╨╛ ╤Б╨║╤Г╤З╨╜╨╛.', 'en', 1966, 'https://en.wikipedia.org/wiki/Robert_Venturi', 'common_attrib', '╨Ы╨╛╨╖╤Г╨╜╨│╨╛╨▓╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨╛╨│╨╛ ╤А╨░╨╖╨▓╨╛╤А╨╛╤В╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(18, 'jencks-language-of-post-modern-architecture-1977', 'text', 'book', 'The Language of Post-Modern Architecture', '╨п╨╖╤Л╨║ ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨╛╨╣ ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╤Л', NULL, NULL, 'en', 1977, 'https://en.wikipedia.org/wiki/Charles_Jencks', 'solid', '╨Ъ╨╗╤О╤З╨╡╨▓╨╛╨╣ ╨╕╤Б╤В╨╛╤З╨╜╨╕╨║-╨╛╨▒╨╛╨▒╤Й╨╡╨╜╨╕╨╡ ╨╕ ╨┐╨╛╨┐╤Г╨╗╤П╤А╨╕╨╖╨░╤Ж╨╕╤П ╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(19, 'jencks-modern-architecture-died-1977', 'quote', 'quote', NULL, NULL, 'Modern Architecture died in St. Louis, Missouri on July 15, 1972...', '╨б╨╛╨▓╤А╨╡╨╝╨╡╨╜╨╜╨░╤П ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░ ╤Г╨╝╨╡╤А╨╗╨░ ╨▓ ╨б╨╡╨╜╤В-╨Ы╤Г╨╕╤Б╨╡ (╨Ь╨╕╤Б╤Б╤Г╤А╨╕) 15 ╨╕╤О╨╗╤П 1972 ╨│╨╛╨┤╨░тАж', 'en', 1977, 'https://en.wikipedia.org/wiki/Pruitt%E2%80%93Igoe', 'solid', '╨д╨╛╤А╨╝╤Г╨╗╨░ ╨Ф╨╢╨╡╨╜╨║╤Б╨░; ╤З╨░╤Б╤В╨╛ ╨┐╤А╨╕╨▓╨╛╨┤╨╕╤В╤Б╤П ╨▓ ╤Г╤З╨╡╨▒╨╜╨╛╨╝ ╨║╨╛╨╜╤В╨╡╨║╤Б╤В╨╡.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(20, 'moma-deconstructivist-architecture-1988', 'text', 'catalog', 'Deconstructivist Architecture (MoMA, 1988)', '╨Ф╨╡╨║╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╤Б╤В╤Б╨║╨░╤П ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░ (MoMA, 1988)', NULL, NULL, 'en', 1988, 'https://en.wikipedia.org/wiki/Deconstructivism', 'solid', '╨Ъ╤Г╤А╨░╤В╨╛╤А╤Б╨║╨░╤П ╤Д╨╕╨║╤Б╨░╤Ж╨╕╤П ╨╜╨░╨┐╤А╨░╨▓╨╗╨╡╨╜╨╕╤П ╤З╨╡╤А╨╡╨╖ ╨▓╤Л╤Б╤В╨░╨▓╨║╤Г/╨║╨░╤В╨░╨╗╨╛╨│.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(21, 'wigley-not-a-new-style-1988', 'quote', 'quote', NULL, NULL, 'Deconstructivist architecture is not a new style.', '╨Ф╨╡╨║╨╛╨╜╤Б╤В╤А╤Г╨║╤В╨╕╨▓╨╕╤Б╤В╤Б╨║╨░╤П ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░ тАФ ╨╜╨╡ ╨╜╨╛╨▓╤Л╨╣ ╤Б╤В╨╕╨╗╤М.', 'en', 1988, 'https://en.wikipedia.org/wiki/Deconstructivism', 'solid', '╨д╨╛╤А╨╝╤Г╨╗╨░ ╨╕╨╖ ╨║╤Г╤А╨░╤В╨╛╤А╤Б╨║╨╛╨│╨╛/╤В╨╡╨╛╤А╨╡╤В╨╕╤З╨╡╤Б╨║╨╛╨│╨╛ ╨┤╨╕╤Б╨║╤Г╤А╤Б╨░ ╨▓╨╛╨║╤А╤Г╨│ ╨▓╤Л╤Б╤В╨░╨▓╨║╨╕ MoMA 1988.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(22, 'pawson-minimum-1996', 'text', 'book', 'Minimum', '╨Ь╨╕╨╜╨╕╨╝╤Г╨╝', NULL, NULL, 'en', 1996, 'https://en.wikipedia.org/wiki/John_Pawson', 'solid', '╨Ъ╨░╨╜╨╛╨╜╨╕╤З╨╡╤Б╨║╨╕╨╣ ╨╕╤Б╤В╨╛╤З╨╜╨╕╨║ ╨┐╨╛ ╨╝╨╕╨╜╨╕╨╝╨░╨╗╨╕╨╖╨╝╤Г (╨║╨░╨║ ╨┤╨╕╤Б╨║╤Г╤А╤Б╤Г/╨┐╤А╨░╨║╤В╨╕╨║╨╡).', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(23, 'pawson-minimum-can-be-maximum-1996', 'quote', 'quote', NULL, NULL, 'The minimum can be the maximum.', '╨Ь╨╕╨╜╨╕╨╝╤Г╨╝ ╨╝╨╛╨╢╨╡╤В ╨▒╤Л╤В╤М ╨╝╨░╨║╤Б╨╕╨╝╤Г╨╝╨╛╨╝.', 'en', 1996, 'https://en.wikipedia.org/wiki/John_Pawson', 'common_attrib', '╨з╨░╤Б╤В╨╛ ╤Ж╨╕╤В╨╕╤А╤Г╨╡╨╝╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░, ╤Б╨▓╤П╨╖╨░╨╜╨╜╨░╤П ╤Б ╨║╨╜╨╕╨│╨╛╨╣ ''Minimum''.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(24, 'rams-weniger-aber-besser', 'quote', 'motto', NULL, NULL, 'Weniger, aber besser.', '╨Ь╨╡╨╜╤М╤И╨╡, ╨╜╨╛ ╨╗╤Г╤З╤И╨╡.', 'de', 1970, 'https://en.wikipedia.org/wiki/Dieter_Rams', 'solid', '╨г╤Б╤В╨╛╨╣╤З╨╕╨▓╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╨Ф╨╕╤В╨╡╤А╨░ ╨а╨░╨╝╤Б╨░; ╤Б╨╕╨╗╤М╨╜╨╛ ╨┐╨╛╨▓╨╗╨╕╤П╨╗╨░ ╨╜╨░ ╨┐╨╛╨╖╨┤╨╜╨╕╨╣ ╨╝╨╕╨╜╨╕╨╝╨░╨╗╨╕╨╖╨╝ ╨▓ ╨┤╨╕╨╖╨░╨╣╨╜╨╡ ╨╕ ╤Б╨╝╨╡╨╢╨╜╤Л╤Е ╨╛╨▒╨╗╨░╤Б╤В╤П╤Е.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(25, 'davies-high-tech-architecture-1988', 'text', 'book', 'High Tech Architecture', '╨Р╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╨░ ╤Е╨░╨╣-╤В╨╡╨║', NULL, NULL, 'en', 1988, 'https://en.wikipedia.org/wiki/High-tech_architecture', 'solid', '╨г╨┤╨╛╨▒╨╜╤Л╨╣ ╤Г╤З╨╡╨▒╨╜╤Л╨╣ ╨╕╤Б╤В╨╛╤З╨╜╨╕╨║/╨╛╨▒╨╖╨╛╤А ╨┐╨╛ high-tech (╨╕╤Б╤В╨╛╤А╨╕╨╛╨│╤А╨░╤Д╨╕╤П).', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(26, 'schumacher-parametricism-great-new-style-2008', 'quote', 'quote', NULL, NULL, 'Parametricism is the great new style after Modernism.', '╨Я╨░╤А╨░╨╝╨╡╤В╤А╨╕╤Ж╨╕╨╖╨╝ тАФ ╨▓╨╡╨╗╨╕╨║╨╕╨╣ ╨╜╨╛╨▓╤Л╨╣ ╤Б╤В╨╕╨╗╤М ╨┐╨╛╤Б╨╗╨╡ ╨╝╨╛╨┤╨╡╤А╨╜╨╕╨╖╨╝╨░.', 'en', 2008, 'https://en.wikipedia.org/wiki/Parametricism', 'solid', '╨Ь╨░╨╜╨╕╤Д╨╡╤Б╤В╨╜╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ ╨Я. ╨и╤Г╨╝╨░╤Е╨╡╤А╨░ (╤З╨░╤Б╤В╨╛ ╤Ж╨╕╤В╨╕╤А╤Г╨╡╤В╤Б╤П ╨▓ ╨┤╨╕╤Б╨║╤Г╤А╤Б╨╡ ╨┐╨░╤А╨░╨╝╨╡╤В╤А╨╕╤Ж╨╕╨╖╨╝╨░).', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(27, 'schumacher-parametricism-ad-2009', 'text', 'article', 'Parametricism: A New Global Style for Architecture and Urban Design', '╨Я╨░╤А╨░╨╝╨╡╤В╤А╨╕╤Ж╨╕╨╖╨╝: ╨╜╨╛╨▓╤Л╨╣ ╨│╨╗╨╛╨▒╨░╨╗╤М╨╜╤Л╨╣ ╤Б╤В╨╕╨╗╤М ╨┤╨╗╤П ╨░╤А╤Е╨╕╤В╨╡╨║╤В╤Г╤А╤Л ╨╕ ╨│╤А╨░╨┤╨╛╤Б╤В╤А╨╛╨╕╤В╨╡╨╗╤М╤Б╤В╨▓╨░', NULL, NULL, 'en', 2009, 'https://en.wikipedia.org/wiki/Patrik_Schumacher', 'solid', '╨Ъ╨╗╤О╤З╨╡╨▓╨╛╨╣ ╤В╨╡╨║╤Б╤В (╨▓ ╤Г╤З╨╡╨▒╨╜╨╛╨╝ ╤Б╨╝╤Л╤Б╨╗╨╡) ╨┤╨╗╤П ╨╝╨░╨╜╨╕╤Д╨╡╤Б╤В╨╜╨╛╨╣ ╤А╨░╨╝╨║╨╕ ╨┐╨░╤А╨░╨╝╨╡╤В╤А╨╕╤Ж╨╕╨╖╨╝╨░.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(28, 'ingels-yes-is-more-2009', 'text', 'book', 'Yes Is More', 'Yes Is More', NULL, NULL, 'en', 2009, 'https://en.wikipedia.org/wiki/Bjarke_Ingels', 'solid', '╨Ъ╨╜╨╕╨│╨░-╨╝╨░╨╜╨╕╤Д╨╡╤Б╤В/╤Б╨░╨╝╨╛╨╛╨┐╨╕╤Б╨░╨╜╨╕╨╡ BIG; ╤З╨░╤Б╤В╨╛ ╨╕╤Б╨┐╨╛╨╗╤М╨╖╤Г╨╡╤В╤Б╤П ╨║╨░╨║ ╨╝╨░╤А╨║╨╡╤А ╨┐╨╛╤Б╤В-╨┐╨╛╤Б╤В╨╝╨╛╨┤╨╡╤А╨╜╨╕╤Б╤В╤Б╨║╨╛╨╣ ╨╗╨╛╨│╨╕╨║╨╕ ''╨╕ ╤В╨╛, ╨╕ ╨┤╤А╤Г╨│╨╛╨╡''.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00'),
	(29, 'ingels-yes-is-more-quote-2009', 'quote', 'motto', NULL, NULL, 'Yes Is More.', '╨Ф╨░ тАФ ╨╖╨╜╨░╤З╨╕╤В ╨▒╨╛╨╗╤М╤И╨╡.', 'en', 2009, 'https://en.wikipedia.org/wiki/Bjarke_Ingels', 'solid', '╨Ы╨╛╨╖╤Г╨╜╨│╨╛╨▓╨░╤П ╤Д╨╛╤А╨╝╤Г╨╗╨░ BIG.', true, '2025-12-12 22:58:02.247862+00', '2025-12-12 22:58:02.247862+00');


--
-- Data for Name: reference_author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."reference_author" ("reference_id", "author_id", "role") VALUES
	(2, 1, 'author'),
	(3, 2, 'author'),
	(4, 2, 'said_by'),
	(5, 3, 'author'),
	(6, 4, 'author'),
	(7, 4, 'said_by'),
	(8, 4, 'attributed_to'),
	(9, 5, 'author'),
	(11, 6, 'author'),
	(12, 6, 'said_by'),
	(13, 8, 'author'),
	(14, 8, 'said_by'),
	(15, 9, 'said_by'),
	(16, 10, 'author'),
	(17, 10, 'said_by'),
	(18, 11, 'author'),
	(19, 11, 'said_by'),
	(20, 12, 'author'),
	(21, 12, 'said_by'),
	(22, 13, 'author'),
	(23, 13, 'said_by'),
	(24, 14, 'said_by'),
	(27, 15, 'author'),
	(26, 15, 'said_by'),
	(28, 16, 'author'),
	(29, 16, 'said_by');


--
-- Data for Name: style_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."style_reference" ("style_id", "reference_id", "relation_type", "is_primary", "sort_order", "note") VALUES
	(1, 1, 'slogan', true, 10, NULL),
	(1, 2, 'key_text', true, 10, NULL),
	(2, 4, 'slogan', true, 10, NULL),
	(2, 3, 'key_text', true, 10, NULL),
	(3, 5, 'key_text', true, 10, NULL),
	(4, 7, 'slogan', true, 10, NULL),
	(4, 8, 'slogan', false, 20, NULL),
	(4, 6, 'key_text', true, 10, NULL),
	(5, 9, 'key_text', true, 10, NULL),
	(6, 10, 'key_text', true, 10, NULL),
	(7, 12, 'slogan', true, 10, NULL),
	(7, 11, 'key_text', true, 10, NULL),
	(8, 14, 'slogan', true, 10, NULL),
	(8, 13, 'key_text', true, 10, NULL),
	(9, 15, 'slogan', true, 10, NULL),
	(9, 25, 'key_text', true, 10, NULL),
	(10, 17, 'slogan', true, 10, NULL),
	(10, 16, 'key_text', true, 10, NULL),
	(10, 19, 'context', false, 20, NULL),
	(11, 21, 'slogan', true, 10, NULL),
	(11, 20, 'key_text', true, 10, NULL),
	(12, 23, 'slogan', true, 10, NULL),
	(12, 24, 'slogan', false, 20, NULL),
	(12, 22, 'key_text', true, 10, NULL),
	(13, 26, 'slogan', true, 10, NULL),
	(13, 27, 'key_text', true, 10, NULL),
	(14, 29, 'slogan', true, 10, NULL),
	(14, 28, 'key_text', true, 10, NULL);


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."authors_id_seq"', 16, true);


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."features_id_seq"', 1, true);


--
-- Name: media_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."media_assets_id_seq"', 21, true);


--
-- Name: phenomena_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."phenomena_id_seq"', 4, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."projects_id_seq"', 24, true);


--
-- Name: reference_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."reference_entries_id_seq"', 29, true);


--
-- Name: styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."styles_id_seq"', 14, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict 4CbdiaHbPno1JIUVJT25GmhKcT5tev7V0Jqu7RpGkVdT5UTxAJgDrFuXKiUcgCn

RESET ALL;
