Add-Type -AssemblyName System.Drawing
$root = "d:\Harish nilam medical documents\pandit doctor receipt (1)\harish\infralytix-technologies\src\main\resources\static\images"
$dirs = @("hero","services","industries","technologies","blogs","portfolio","about","team","pages")
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path (Join-Path $root $d) | Out-Null }

function Draw-IsoCube($g, $cx, $cy, $size, $hue) {
    $top = [System.Drawing.Color]::FromArgb(90, 0, 188, 242)
    $left = [System.Drawing.Color]::FromArgb(70, 0, 120, 212)
    $right = [System.Drawing.Color]::FromArgb(110, 80, 230, 255)
    $hw = $size * 0.5; $hh = $size * 0.28
    $ptsTop = @(
        [System.Drawing.Point]::new([int]($cx), [int]($cy - $hh)),
        [System.Drawing.Point]::new([int]($cx + $hw), [int]$cy),
        [System.Drawing.Point]::new([int]$cx, [int]($cy + $hh)),
        [System.Drawing.Point]::new([int]($cx - $hw), [int]$cy)
    )
    $ptsLeft = @(
        [System.Drawing.Point]::new([int]($cx - $hw), [int]$cy),
        [System.Drawing.Point]::new([int]$cx, [int]($cy + $hh)),
        [System.Drawing.Point]::new([int]$cx, [int]($cy + $hh + $size * 0.35)),
        [System.Drawing.Point]::new([int]($cx - $hw), [int]($cy + $size * 0.35))
    )
    $ptsRight = @(
        [System.Drawing.Point]::new([int]$cx, [int]($cy + $hh)),
        [System.Drawing.Point]::new([int]($cx + $hw), [int]$cy),
        [System.Drawing.Point]::new([int]($cx + $hw), [int]($cy + $size * 0.35)),
        [System.Drawing.Point]::new([int]$cx, [int]($cy + $hh + $size * 0.35))
    )
    $g.FillPolygon((New-Object System.Drawing.SolidBrush $left), $ptsLeft)
    $g.FillPolygon((New-Object System.Drawing.SolidBrush $right), $ptsRight)
    $g.FillPolygon((New-Object System.Drawing.SolidBrush $top), $ptsTop)
    $edgePen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(120, 80, 230, 255), 1.5)
    $g.DrawPolygon($edgePen, $ptsTop); $g.DrawPolygon($edgePen, $ptsLeft); $g.DrawPolygon($edgePen, $ptsRight)
    $edgePen.Dispose()
}

function Draw-3DGrid($g, $w, $h, $hue) {
    $pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(35, 0, 188, 242), 1)
    $vanishY = [int]($h * 0.35)
    $vanishX = [int]($w * 0.5)
    for ($i = -8; $i -le 8; $i++) {
        $bx = $vanishX + $i * 80
        $g.DrawLine($pen, $bx, $h, $vanishX, $vanishY)
    }
    for ($j = 0; $j -lt 12; $j++) {
        $yy = $vanishY + $j * ([int](($h - $vanishY) / 12))
        $spread = 40 + $j * 55
        $g.DrawLine($pen, $vanishX - $spread, $yy, $vanishX + $spread, $yy)
    }
    $pen.Dispose()
}

function Draw-HoloPanel($g, $x, $y, $pw, $ph, $hue) {
    $rect = New-Object System.Drawing.Rectangle $x, $y, $pw, $ph
    $fill = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(45, 10, 20, 40))
    $g.FillRectangle($fill, $rect)
    $fill.Dispose()
    $borderPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(100, 0, 188, 242), 2)
    $g.DrawRectangle($borderPen, $rect)
    $borderPen.Dispose()
    for ($li = 0; $li -lt 5; $li++) {
        $ly = $y + 20 + $li * [int]($ph / 6)
        $lineBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(30 + $li * 8, 0, 188, 242))
        $g.FillRectangle($lineBrush, $x + 15, $ly, [int]($pw * 0.6), 3)
        $lineBrush.Dispose()
    }
    $glow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(25, 0, 188, 242))
    $g.FillEllipse($glow, $x - 20, $y - 20, $pw + 40, $ph + 40)
    $glow.Dispose()
}

function New-PremiumImage($path, $title, $subtitle, $hue, $w, $h) {
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.InterpolationMode = 'HighQualityBicubic'

    $bg1 = [System.Drawing.Color]::FromArgb(4, 8, 18)
    $bg2 = [System.Drawing.Color]::FromArgb(0, [Math]::Min(200, 30 + $hue), [Math]::Min(240, 70 + $hue))
    $bg3 = [System.Drawing.Color]::FromArgb(8, 16, 36)
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (
        (New-Object System.Drawing.Rectangle 0, 0, $w, $h), $bg1, $bg2,
        [System.Drawing.Drawing2D.LinearGradientMode]::ForwardDiagonal)
    $g.FillRectangle($brush, 0, 0, $w, $h)
    $brush.Dispose()

    Draw-3DGrid $g $w $h $hue

    $rng = New-Object System.Random $hue

    for ($orb = 0; $orb -lt 6; $orb++) {
        $ox = $rng.Next([int]($w * 0.1), [int]($w * 0.9))
        $oy = $rng.Next([int]($h * 0.05), [int]($h * 0.6))
        $os = $rng.Next(40, 120)
        $alpha = $rng.Next(15, 45)
        $glowBrush = New-Object System.Drawing.Drawing2D.PathGradientBrush @(
            [System.Drawing.Point]::new($ox - $os, $oy - $os),
            [System.Drawing.Point]::new($ox + $os, $oy - $os),
            [System.Drawing.Point]::new($ox + $os, $oy + $os),
            [System.Drawing.Point]::new($ox - $os, $oy + $os)
        )
        $glowBrush.CenterColor = [System.Drawing.Color]::FromArgb($alpha, 0, 188, 242)
        $glowBrush.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        $g.FillEllipse($glowBrush, $ox - $os, $oy - $os, $os * 2, $os * 2)
        $glowBrush.Dispose()
    }

    Draw-HoloPanel $g ([int]($w * 0.52)) ([int]($h * 0.12)) ([int]($w * 0.38)) ([int]($h * 0.45)) $hue
    Draw-IsoCube $g ([int]($w * 0.25)) ([int]($h * 0.42)) 90 $hue
    Draw-IsoCube $g ([int]($w * 0.72)) ([int]($h * 0.55)) 60 ($hue + 30)
    Draw-IsoCube $g ([int]($w * 0.38)) ([int]($h * 0.62)) 45 ($hue + 60)

    $nodeBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(80, 80, 230, 255))
    $nodes = @()
    for ($i = 0; $i -lt 50; $i++) {
        $nx = $rng.Next(0, $w); $ny = $rng.Next(0, $h); $ns = $rng.Next(3, 8)
        $g.FillEllipse($nodeBrush, $nx, $ny, $ns, $ns)
        $nodes += ,@($nx, $ny)
    }
    $nodeBrush.Dispose()

    $linePen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(50, 0, 188, 242), 1.2)
    for ($i = 0; $i -lt 30; $i++) {
        $g.DrawLine($linePen, $rng.Next(0,$w), $rng.Next(0,$h), $rng.Next(0,$w), $rng.Next(0,$h))
    }
    for ($i = 0; $i -lt $nodes.Count; $i++) {
        for ($j = $i + 1; $j -lt $nodes.Count; $j++) {
            $dx = $nodes[$i][0] - $nodes[$j][0]; $dy = $nodes[$i][1] - $nodes[$j][1]
            if ([Math]::Sqrt($dx*$dx + $dy*$dy) -lt 100) {
                $g.DrawLine($linePen, $nodes[$i][0], $nodes[$i][1], $nodes[$j][0], $nodes[$j][1])
            }
        }
    }
    $linePen.Dispose()

    $scanPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(20, 0, 188, 242), 1)
    for ($s = 0; $s -lt $h; $s += 4) { $g.DrawLine($scanPen, 0, $s, $w, $s) }
    $scanPen.Dispose()

    $mainGlow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(70, 0, 188, 242))
    $g.FillEllipse($mainGlow, [int]($w*0.45), [int]($h*0.08), [int]($w*0.4), [int]($h*0.5))
    $mainGlow.Dispose()

    $titleFont = New-Object System.Drawing.Font("Segoe UI", [Math]::Max(16, [int]($w/24)), [System.Drawing.FontStyle]::Bold)
    $subFont = New-Object System.Drawing.Font("Segoe UI", [Math]::Max(10, [int]($w/40)), [System.Drawing.FontStyle]::Regular)
    $white = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(250, 252, 255))
    $cyan = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(80, 230, 255))
    $shadow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(80, 0, 0, 0))
    $g.DrawString($title, $titleFont, $shadow, 39, ($h - 118))
    $g.DrawString($title, $titleFont, $white, 36, ($h - 120))
    if ($subtitle) {
        $g.DrawString($subtitle, $subFont, $cyan, 36, ($h - 72))
    }

    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $bmp.Dispose()
    Write-Host "Created $path"
}

$services = @{
    "enterprise-software-development.jpg" = @("Enterprise Software", "Java | Spring Boot | Architecture", 200)
    "ai-solutions.jpg" = @("AI Solutions", "Neural Networks | Machine Learning", 185)
    "cloud-engineering.jpg" = @("Cloud Engineering", "AWS | Azure | Infrastructure", 210)
    "devops.jpg" = @("DevOps", "CI/CD | Kubernetes | Docker", 195)
    "platform-engineering.jpg" = @("Platform Engineering", "Developer Platforms", 175)
    "microservices.jpg" = @("Microservices", "Distributed APIs", 165)
    "api-integration.jpg" = @("API Integration", "Enterprise API Gateway", 155)
    "application-modernization.jpg" = @("App Modernization", "Legacy to Cloud", 145)
    "observability.jpg" = @("Observability", "Grafana | Prometheus", 225)
    "cyber-security.jpg" = @("Cyber Security", "Enterprise Protection", 0)
    "performance-engineering.jpg" = @("Performance Engineering", "JVM | Analytics", 35)
    "application-support.jpg" = @("Application Support", "24x7 Enterprise Support", 25)
}
foreach ($k in $services.Keys) {
    $v = $services[$k]
    New-PremiumImage (Join-Path $root "services\$k") $v[0] $v[1] $v[2] 1200 675
}

$industries = @{
    "banking.jpg" = @("Banking", "Digital Banking Platform", 205)
    "healthcare.jpg" = @("Healthcare", "Digital Hospital Systems", 170)
    "insurance.jpg" = @("Insurance", "Analytics Dashboard", 190)
    "government.jpg" = @("Government", "Smart City | e-Governance", 160)
    "manufacturing.jpg" = @("Manufacturing", "Industry 4.0 Factory", 140)
    "retail.jpg" = @("Retail", "AI Shopping Experience", 180)
    "telecom.jpg" = @("Telecom", "5G Communication Network", 215)
    "education.jpg" = @("Education", "Digital Learning Platform", 150)
}
foreach ($k in $industries.Keys) {
    $v = $industries[$k]
    New-PremiumImage (Join-Path $root "industries\$k") $v[0] $v[1] $v[2] 1200 675
}

$techs = @{
    "java.jpg"=200;"spring-boot.jpg"=198;"react.jpg"=185;"angular.jpg"=175;"python.jpg"=165
    "aws.jpg"=210;"azure.jpg"=205;"docker.jpg"=195;"kubernetes.jpg"=190;"kafka.jpg"=180
    "redis.jpg"=170;"oracle.jpg"=160;"mongodb.jpg"=155;"postgresql.jpg"=150
    "grafana.jpg"=225;"prometheus.jpg"=220;"opentelemetry.jpg"=215
    "github.jpg"=140;"gitlab.jpg"=135;"jenkins.jpg"=130
}
foreach ($k in $techs.Keys) {
    $name = ($k -replace '.jpg','' -replace '-',' ').ToUpper()
    if ($name -eq 'SPRING BOOT') { $name = 'Spring Boot' }
    elseif ($name -eq 'POSTGRESQL') { $name = 'PostgreSQL' }
    elseif ($name -eq 'OPENTELEMETRY') { $name = 'OpenTelemetry' }
    else { $name = (Get-Culture).TextInfo.ToTitleCase($name.ToLower()) }
    New-PremiumImage (Join-Path $root "technologies\$k") $name "Enterprise Technology" $techs[$k] 800 500
}

$blogs = @{
    "ai.jpg"=185;"cloud.jpg"=210;"java.jpg"=200;"spring-boot.jpg"=198;"devops.jpg"=195
    "monitoring.jpg"=225;"security.jpg"=0;"architecture.jpg"=175
}
foreach ($k in $blogs.Keys) {
    $label = ($k -replace '.jpg','').ToUpper()
    New-PremiumImage (Join-Path $root "blogs\$k") $label "INFRALYTIX Insights" $blogs[$k] 1200 675
}

$portfolio = @{
    "enterprise-banking.jpg"=205;"ai-chatbot.jpg"=185;"cloud-migration.jpg"=210
    "monitoring-dashboard.jpg"=225;"devops-automation.jpg"=195;"microservices-platform.jpg"=165
}
foreach ($k in $portfolio.Keys) {
    $label = ($k -replace '.jpg','' -replace '-',' ').ToUpper()
    New-PremiumImage (Join-Path $root "portfolio\$k") $label "Enterprise Project" $portfolio[$k] 1200 675
}

New-PremiumImage (Join-Path $root "hero\hero-main.jpg") "INFRALYTIX TECHNOLOGIES" "Powering Intelligent Infrastructure" 200 1920 1080
New-PremiumImage (Join-Path $root "about\about-hero.jpg") "Enterprise Innovation" "AI | Cloud | Digital Transformation" 190 1400 900
New-PremiumImage (Join-Path $root "team\harish-palkar.jpg") "HARISH PALKAR" "Founder & Technical Director" 200 600 750

Copy-Item (Join-Path $root "hero\hero-main.jpg") (Join-Path $root "pages\home.jpg") -Force
Copy-Item (Join-Path $root "services\cloud-engineering.jpg") (Join-Path $root "pages\services.jpg") -Force
Copy-Item (Join-Path $root "about\about-hero.jpg") (Join-Path $root "pages\about.jpg") -Force
Copy-Item (Join-Path $root "technologies\java.jpg") (Join-Path $root "pages\technologies.jpg") -Force
Copy-Item (Join-Path $root "industries\banking.jpg") (Join-Path $root "pages\industries.jpg") -Force
Copy-Item (Join-Path $root "portfolio\enterprise-banking.jpg") (Join-Path $root "pages\portfolio.jpg") -Force
Copy-Item (Join-Path $root "blogs\ai.jpg") (Join-Path $root "pages\blogs.jpg") -Force
Copy-Item (Join-Path $root "team\harish-palkar.jpg") (Join-Path $root "pages\careers.jpg") -Force
Copy-Item (Join-Path $root "hero\hero-main.jpg") (Join-Path $root "pages\contact.jpg") -Force
Copy-Item (Join-Path $root "services\ai-solutions.jpg") (Join-Path $root "pages\solutions.jpg") -Force
Copy-Item (Join-Path $root "services\cyber-security.jpg") (Join-Path $root "pages\privacy.jpg") -Force
Copy-Item (Join-Path $root "technologies\opentelemetry.jpg") (Join-Path $root "pages\terms.jpg") -Force

Write-Host "All 3D premium images generated."
