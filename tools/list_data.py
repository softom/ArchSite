# -*- coding: utf-8 -*-
import os
from pathlib import Path

root = Path('E:/Dropbox') / '\u041f\u0420\u0415\u041f\u041e\u0414\u041e\u0412\u0410\u041d\u0418\u0415' / '\u041a\u0420\u042b\u041c \u0414\u0410\u041d\u041d\u042b\u0415'

total = 0
for p in sorted(root.rglob('*')):
    if p.is_file():
        size_mb = p.stat().st_size / 1024 / 1024
        total += size_mb
        rel = p.relative_to(root)
        print(f'{size_mb:8.1f} MB  {rel}')

print(f'\n{"="*50}')
print(f'TOTAL: {total:.1f} MB  ({total/1024:.2f} GB)')
