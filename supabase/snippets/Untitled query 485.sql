alter table public.media_assets
  add column if not exists public_url_local text;