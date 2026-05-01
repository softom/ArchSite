# Copy QGIS media files to server media folder
$src = "e:\Dropbox\Obsidian\Tigra\Анализ\002"
$dst = "d:\WORK ON SERVER\site\gis\media"

$files = Get-ChildItem -Path $src -Filter "*.png" | Where-Object { $_.Name -notmatch "^\d{3} Иллюстрация" }

foreach ($f in $files) {
    $dstPath = Join-Path $dst $f.Name
    [System.IO.File]::Copy($f.FullName, $dstPath, $true)
    Write-Host "Copied: $($f.Name)"
}

Write-Host "Done. Copied $($files.Count) files."
