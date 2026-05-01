import os, sys, shutil
from pathlib import Path

src = Path(r'e:\Dropbox\Obsidian\Tigra') / '\u0410\u043d\u0430\u043b\u0438\u0437' / '002'
dst = Path(r'd:\WORK ON SERVER\site\gis\media')

print('src:', src)
print('src exists:', src.exists())

# Try scandir
try:
    entries = list(os.scandir(str(src)))
    print('scandir count:', len(entries))
    for e in entries:
        print(' -', repr(e.name))
except Exception as ex:
    print('scandir error:', ex)

# Try glob
try:
    pngs = list(src.glob('*.png'))
    print('glob count:', len(pngs))
    for p in pngs:
        print(' -', repr(p.name))
except Exception as ex:
    print('glob error:', ex)
