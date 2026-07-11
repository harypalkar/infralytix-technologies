$assets = "C:\Users\Niya\.cursor\projects\d-Harish-nilam-medical-documents-pandit-doctor-receipt-1-harish-infralytix-technologies\assets"
$outDir = "d:\Harish nilam medical documents\pandit doctor receipt (1)\harish\infralytix-technologies\src\main\resources\static\images"

$dirs = @("hero","services","industries","portfolio","blogs","team","pages","brand")
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path (Join-Path $outDir $d) | Out-Null }

function Copy-Asset($pattern, $dest) {
    $file = Get-ChildItem -LiteralPath $assets -Filter $pattern | Select-Object -First 1
    if (-not $file) { throw "Asset not found: $pattern" }
    $srcLong = "\\?\$($file.FullName)"
    $dstLong = "\\?\$dest"
    [System.IO.File]::Copy($srcLong, $dstLong, $true)
    Write-Host "Copied -> $dest"
}

Copy-Asset "*company_logo*" (Join-Path $outDir "brand\logo-full.png")
Copy-Asset "*latest_images*" (Join-Path $outDir "brand\asset-pack-source.png")

Add-Type -AssemblyName System.Drawing

function Save-Crop($srcPath, $destPath, $x, $y, $w, $h) {
    $src = [System.Drawing.Image]::FromFile("\\?\$srcPath")
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($src, 0, 0, (New-Object System.Drawing.Rectangle $x, $y, $w, $h), [System.Drawing.GraphicsUnit]::Pixel)
    $ext = [System.IO.Path]::GetExtension($destPath).ToLower()
    if ($ext -eq ".png") {
        $bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } else {
        $bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    }
    $g.Dispose(); $bmp.Dispose(); $src.Dispose()
    Write-Host "Cropped -> $destPath"
}

function Save-ResizeLogo($srcPath, $destPath, $size) {
    $src = [System.Drawing.Image]::FromFile("\\?\$srcPath")
    $bmp = New-Object System.Drawing.Bitmap $size, $size
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.Clear([System.Drawing.Color]::Transparent)
    $scale = [Math]::Min($size / $src.Width, $size / $src.Height)
    $nw = [int]($src.Width * $scale)
    $nh = [int]($src.Height * $scale)
    $x = [int](($size - $nw) / 2)
    $y = [int](($size - $nh) / 2)
    $g.DrawImage($src, $x, $y, $nw, $nh)
    $bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose(); $src.Dispose()
    Write-Host "Logo -> $destPath"
}

$pack = Join-Path $outDir "brand\asset-pack-source.png"
$logoFull = Join-Path $outDir "brand\logo-full.png"

$packImg = [System.Drawing.Image]::FromFile("\\?\$pack")
$pw = $packImg.Width
$ph = $packImg.Height
$packImg.Dispose()
Write-Host "Pack: ${pw}x${ph}"

# Navbar / favicon logos from company logo
Save-ResizeLogo $logoFull (Join-Path $outDir "logo.png") 220
Save-Crop $logoFull (Join-Path $outDir "brand\logo-icon.png") 30 40 380 380

# Grid cell size estimates for the asset pack (4 columns)
$cellW = [int]($pw / 4.2)
$cellH = [int]($cellW * 0.72)

# Section Y offsets (tuned for vertical layout)
$heroY = [int]($ph * 0.115)
$serviceY = [int]($ph * 0.255)
$industryY = [int]($ph * 0.405)
$portfolioY = [int]($ph * 0.555)
$extraY = [int]($ph * 0.695)
$teamY = [int]($ph * 0.775)
$blogY = [int]($ph * 0.875)

function Crop-Row($baseY, $names) {
    for ($i = 0; $i -lt $names.Count; $i++) {
        $x = [int]($pw * 0.04) + ($i * $cellW)
        $dest = Join-Path $outDir $names[$i]
        Save-Crop $pack $dest $x $baseY $cellW $cellH
    }
}

# Hero backgrounds
Crop-Row $heroY @(
    "hero\hero-bg.jpg",
    "hero\ai-globe.jpg",
    "hero\network-bg.jpg",
    "hero\circuit-bg.jpg"
)

# Service images
Crop-Row $serviceY @(
    "services\ai-solutions.jpg",
    "services\cloud-engineering.jpg",
    "services\devops.jpg",
    "services\platform-engineering.jpg"
)
$x0 = [int]($pw * 0.04)
Save-Crop $pack (Join-Path $outDir "services\observability.jpg") $x0 ($serviceY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "services\cyber-security.jpg") ($x0 + $cellW) ($serviceY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "services\data-analytics.jpg") ($x0 + $cellW * 2) ($serviceY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "services\microservices.jpg") ($x0 + $cellW * 3) ($serviceY + $cellH + 20) $cellW $cellH

# Industry images
Crop-Row $industryY @(
    "industries\banking.jpg",
    "industries\healthcare.jpg",
    "industries\government.jpg",
    "industries\retail.jpg"
)
Save-Crop $pack (Join-Path $outDir "industries\insurance.jpg") $x0 ($industryY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "industries\manufacturing.jpg") ($x0 + $cellW) ($industryY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "industries\education.jpg") ($x0 + $cellW * 2) ($industryY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "industries\telecom.jpg") ($x0 + $cellW * 3) ($industryY + $cellH + 20) $cellW $cellH

# Portfolio images
Crop-Row $portfolioY @(
    "portfolio\enterprise-banking.jpg",
    "portfolio\cloud-migration.jpg",
    "portfolio\devops-automation.jpg",
    "portfolio\ai-chatbot.jpg"
)
Save-Crop $pack (Join-Path $outDir "portfolio\monitoring-dashboard.jpg") $x0 ($portfolioY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "portfolio\payment-gateway.jpg") ($x0 + $cellW) ($portfolioY + $cellH + 20) $cellW $cellH
Save-Crop $pack (Join-Path $outDir "portfolio\microservices-platform.jpg") ($x0 + $cellW * 2) ($portfolioY + $cellH + 20) $cellW $cellH

# Team images
Crop-Row $teamY @(
    "team\team-collaboration.jpg",
    "team\meeting-room.jpg",
    "team\office-building.jpg",
    "team\leadership.jpg"
)

# Blog images
Crop-Row $blogY @(
    "blogs\blog-ai.jpg",
    "blogs\blog-cloud.jpg",
    "blogs\blog-devops.jpg",
    "blogs\blog-security.jpg"
)

# Page hero banners
Copy-Item (Join-Path $outDir "hero\hero-bg.jpg") (Join-Path $outDir "pages\home.jpg") -Force
Copy-Item (Join-Path $outDir "services\cloud-engineering.jpg") (Join-Path $outDir "pages\services.jpg") -Force
Copy-Item (Join-Path $outDir "team\leadership.jpg") (Join-Path $outDir "pages\about.jpg") -Force
Copy-Item (Join-Path $outDir "hero\circuit-bg.jpg") (Join-Path $outDir "pages\technologies.jpg") -Force
Copy-Item (Join-Path $outDir "industries\banking.jpg") (Join-Path $outDir "pages\industries.jpg") -Force
Copy-Item (Join-Path $outDir "portfolio\enterprise-banking.jpg") (Join-Path $outDir "pages\portfolio.jpg") -Force
Copy-Item (Join-Path $outDir "blogs\blog-ai.jpg") (Join-Path $outDir "pages\blogs.jpg") -Force
Copy-Item (Join-Path $outDir "team\team-collaboration.jpg") (Join-Path $outDir "pages\careers.jpg") -Force
Copy-Item (Join-Path $outDir "team\office-building.jpg") (Join-Path $outDir "pages\contact.jpg") -Force
Copy-Item (Join-Path $outDir "services\cyber-security.jpg") (Join-Path $outDir "pages\solutions.jpg") -Force
Copy-Item (Join-Path $outDir "services\cyber-security.jpg") (Join-Path $outDir "pages\privacy.jpg") -Force
Copy-Item (Join-Path $outDir "hero\network-bg.jpg") (Join-Path $outDir "pages\terms.jpg") -Force

# Legacy aliases
Copy-Item (Join-Path $outDir "hero\hero-bg.jpg") (Join-Path $outDir "hero-bg.jpg") -Force
Copy-Item (Join-Path $outDir "services\ai-solutions.jpg") (Join-Path $outDir "ai.jpg") -Force
Copy-Item (Join-Path $outDir "services\cloud-engineering.jpg") (Join-Path $outDir "cloud.jpg") -Force
Copy-Item (Join-Path $outDir "portfolio\microservices-platform.jpg") (Join-Path $outDir "java.jpg") -Force
Copy-Item (Join-Path $outDir "industries\banking.jpg") (Join-Path $outDir "banking.jpg") -Force
Copy-Item (Join-Path $outDir "services\cyber-security.jpg") (Join-Path $outDir "security.jpg") -Force
Copy-Item (Join-Path $outDir "portfolio\monitoring-dashboard.jpg") (Join-Path $outDir "monitoring.jpg") -Force

Write-Host "Brand image setup complete."
