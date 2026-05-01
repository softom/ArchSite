# -*- coding: utf-8 -*-
import shutil
from pathlib import Path

# Source folder: Анализ/005/
src_dir = Path('e:/Dropbox/Obsidian/Tigra') / '\u0410\u043d\u0430\u043b\u0438\u0437' / '005'
dst_media = Path('d:/WORK ON SERVER/site/gis/media')
dst_obsidian = Path('e:/Dropbox/Obsidian/Tigra') / 'GIS \u0441\u0438\u0441\u0442\u0435\u043c\u044b' / 'media' / 'QGIS'

rename_map = {
    '5392b38260c0124c1458f504cfd6c576.jpg': 'morpho_007_01_pastvu.jpg',
    'b_year_1.jpg':                          'morpho_007_02_building_age.jpg',
    'FINAL MORPHOLOGY.jpg':                  'morpho_007_03_final.jpg',
}

for orig, new_name in rename_map.items():
    src = src_dir / orig
    if src.exists():
        shutil.copy2(src, dst_media / new_name)
        shutil.copy2(src, dst_obsidian / new_name)
        print(f'Copied: {orig} -> {new_name}')
    else:
        print(f'NOT FOUND: {orig}')

print('Done')
