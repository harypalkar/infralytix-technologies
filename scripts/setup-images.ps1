$assets = "C:\Users\Niya\.cursor\projects\d-Harish-nilam-medical-documents-pandit-doctor-receipt-1-harish-infralytix-technologies\assets"
$outDir = "d:\Harish nilam medical documents\pandit doctor receipt (1)\harish\infralytix-technologies\src\main\resources\static\images"
$pagesDir = Join-Path $outDir "pages"
New-Item -ItemType Directory -Force -Path $pagesDir | Out-Null

$first = (cmd /c "dir /b ""$assets""" | Select-Object -First 1).Trim()
$mockupShort = Join-Path $outDir "mockup-source.png"
if (-not (Test-Path $mockupShort)) {
    $srcLong = "\\?\$((Join-Path $assets $first))"
    $dstLong = "\\?\$mockupShort"
    [System.IO.File]::Copy($srcLong, $dstLong, $true)
}

Add-Type -AssemblyName System.Drawing
$src = [System.Drawing.Image]::FromFile("\\?\$mockupShort")
$w = $src.Width
$h = $src.Height
Write-Host "Mockup dimensions: ${w}x${h}"

function Save-Crop($name, $x, $y, $cw, $ch, $format) {
    $bmp = New-Object System.Drawing.Bitmap $cw, $ch
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($src, 0, 0, (New-Object System.Drawing.Rectangle $x, $y, $cw, $ch), [System.Drawing.GraphicsUnit]::Pixel)
    $path = Join-Path $pagesDir $name
    if ($format -eq 'jpg') {
        $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    } else {
        $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Created $name (${cw}x${ch})"
}

$colW = [int]($w / 3)
$rowH = [int]($h / 3)
$lastColW = $w - ($colW * 2)
$lastRowH = $h - ($rowH * 2)

Save-Crop "home.jpg" 0 0 $colW $rowH 'jpg'
Save-Crop "services.jpg" $colW 0 $colW $rowH 'jpg'
Save-Crop "about.jpg" ($colW * 2) 0 $lastColW $rowH 'jpg'
Save-Crop "technologies.jpg" 0 $rowH $colW $rowH 'jpg'
Save-Crop "portfolio.jpg" $colW $rowH $colW $rowH 'jpg'
Save-Crop "industries.jpg" ($colW * 2) $rowH $lastColW $rowH 'jpg'
Save-Crop "blogs.jpg" 0 ($rowH * 2) $colW $lastRowH 'jpg'
Save-Crop "careers.jpg" $colW ($rowH * 2) $colW $lastRowH 'jpg'
Save-Crop "contact.jpg" ($colW * 2) ($rowH * 2) $lastColW $lastRowH 'jpg'
Save-Crop "solutions.jpg" $colW $rowH $colW $rowH 'jpg'
Save-Crop "privacy.jpg" ($colW * 2) ($rowH * 2) $lastColW $lastRowH 'jpg'
Save-Crop "terms.jpg" 0 ($rowH * 2) $colW $lastRowH 'jpg'
Save-Crop "logo.png" 40 30 180 180 'png'

$maps = @{
    "hero-bg.jpg" = "home.jpg"
    "ai.jpg" = "home.jpg"
    "cloud.jpg" = "technologies.jpg"
    "java.jpg" = "portfolio.jpg"
    "banking.jpg" = "industries.jpg"
    "security.jpg" = "services.jpg"
    "monitoring.jpg" = "blogs.jpg"
}
foreach ($dest in $maps.Keys) {
    Copy-Item (Join-Path $pagesDir $maps[$dest]) (Join-Path $outDir $dest) -Force
}
Copy-Item (Join-Path $pagesDir "logo.png") (Join-Path $outDir "logo.png") -Force

$src.Dispose()
Get-ChildItem $pagesDir | Format-Table Name, Length -AutoSize
