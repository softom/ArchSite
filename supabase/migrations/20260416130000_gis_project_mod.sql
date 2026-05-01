-- ============================================================
-- gis_project: политики модератора (authenticated role)
-- ============================================================

-- authenticated может читать ВСЕ строки (включая hidden)
CREATE POLICY "mod_select"
  ON public.gis_project FOR SELECT
  TO authenticated
  USING (true);

-- authenticated может обновлять (скрывать/показывать)
CREATE POLICY "mod_update"
  ON public.gis_project FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

GRANT SELECT, UPDATE ON public.gis_project TO authenticated;
