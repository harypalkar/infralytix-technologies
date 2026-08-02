# Generate topic-specific enterprise imagery (not generic cube/network placeholders)
Add-Type -AssemblyName System.Drawing
$root = "d:\Harish nilam medical documents\pandit doctor receipt (1)\harish\infralytix-technologies\src\main\resources\static\images"
$dirs = @("hero","services","industries","technologies","blogs","portfolio","about","team","pages")
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path (Join-Path $root $d) | Out-Null }

function New-Brush([int]$a,[int]$r,[int]$g,[int]$b) {
    New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb($a,$r,$g,$b))
}
function New-PenC([int]$a,[int]$r,[int]$g,[int]$b,[float]$w=1.5) {
    New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb($a,$r,$g,$b), $w)
}

function Fill-Base($g, $w, $h, $theme) {
    $palettes = @{
        ai       = @(4,8,20, 12,40,90, 0,180,220)
        cloud    = @(6,14,32, 20,60,120, 80,180,255)
        security = @(10,8,18, 40,20,50, 0,200,160)
        banking  = @(8,12,28, 16,40,80, 0,140,220)
        health   = @(6,16,22, 10,60,70, 0,200,180)
        factory  = @(12,14,20, 40,50,70, 255,160,60)
        data     = @(4,10,24, 20,50,100, 100,80,255)
        code     = @(6,10,18, 20,40,60, 0,220,140)
        default  = @(4,8,18, 10,30,70, 0,160,220)
    }
    if (-not $palettes.ContainsKey($theme)) { $theme = 'default' }
    $p = $palettes[$theme]
    $rect = New-Object System.Drawing.Rectangle 0, 0, $w, $h
    $b1 = [System.Drawing.Color]::FromArgb([int]$p[0], [int]$p[1], [int]$p[2])
    $b2 = [System.Drawing.Color]::FromArgb([int]$p[3], [int]$p[4], [int]$p[5])
    $mode = [System.Drawing.Drawing2D.LinearGradientMode]::ForwardDiagonal
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, $b1, $b2, $mode
    $g.FillRectangle($brush, $rect)
    $brush.Dispose()
    $glow = New-Brush 40 ([int]$p[6]) ([int]$p[7]) ([int]$p[8])
    $g.FillEllipse($glow, [int]($w*0.35), [int]($h*0.05), [int]($w*0.5), [int]($h*0.55))
    $glow.Dispose()
}

function Draw-Neural($g, $w, $h) {
    $rng = New-Object System.Random 42
    $layers = @(6, 9, 7, 5)
    $pts = @()
    for ($L = 0; $L -lt $layers.Count; $L++) {
        $x = [int]($w * (0.18 + $L * 0.18))
        $n = $layers[$L]
        $layerPts = @()
        for ($i = 0; $i -lt $n; $i++) {
            $y = [int]($h * (0.18 + $i * (0.55 / [Math]::Max(1, $n-1))))
            $layerPts += ,[System.Drawing.Point]::new($x, $y)
        }
        $pts += ,$layerPts
    }
    $pen = New-PenC 70 80 230 255 1.2
    for ($L = 0; $L -lt $pts.Count - 1; $L++) {
        foreach ($a in $pts[$L]) {
            foreach ($b in $pts[$L+1]) {
                if ($rng.NextDouble() -gt 0.35) { $g.DrawLine($pen, $a, $b) }
            }
        }
    }
    $pen.Dispose()
    $node = New-Brush 220 80 230 255
    $core = New-Brush 255 255 255 255
    foreach ($layer in $pts) {
        foreach ($p in $layer) {
            $g.FillEllipse($node, $p.X-7, $p.Y-7, 14, 14)
            $g.FillEllipse($core, $p.X-3, $p.Y-3, 6, 6)
        }
    }
    $node.Dispose(); $core.Dispose()
}

function Draw-CloudInfra($g, $w, $h) {
    $pen = New-PenC 90 120 200 255 2
    $fill = New-Brush 50 0 120 212
    # server racks
    for ($i = 0; $i -lt 3; $i++) {
        $x = [int]($w*0.12 + $i*($w*0.18))
        $y = [int]($h*0.28)
        $rw = [int]($w*0.12); $rh = [int]($h*0.42)
        $g.FillRectangle($fill, $x, $y, $rw, $rh)
        $g.DrawRectangle($pen, $x, $y, $rw, $rh)
        for ($s = 0; $s -lt 6; $s++) {
            $sy = $y + 18 + $s * [int]($rh/7)
            $led = New-Brush 200 80 255 180
            $g.FillRectangle((New-Brush 40 20 40 70), $x+10, $sy, $rw-20, 10)
            $g.FillEllipse($led, $x+$rw-22, $sy+2, 6, 6)
            $led.Dispose()
        }
    }
    # cloud arcs
    $cloudPen = New-PenC 120 80 230 255 3
    $cx = [int]($w*0.72); $cy = [int]($h*0.28)
    $g.DrawArc($cloudPen, $cx-90, $cy-40, 100, 70, 200, 140)
    $g.DrawArc($cloudPen, $cx-40, $cy-55, 110, 80, 200, 160)
    $g.DrawArc($cloudPen, $cx+20, $cy-35, 90, 65, 210, 130)
    $cloudPen.Dispose(); $pen.Dispose(); $fill.Dispose()
}

function Draw-Dashboard($g, $w, $h) {
    $panel = New-Brush 70 8 20 40
    $border = New-PenC 140 0 188 242 2
    $g.FillRectangle($panel, [int]($w*0.12), [int]($h*0.15), [int]($w*0.76), [int]($h*0.55))
    $g.DrawRectangle($border, [int]($w*0.12), [int]($h*0.15), [int]($w*0.76), [int]($h*0.55))
    # chart bars
    $bar = New-Brush 180 0 188 242
    $vals = @(0.35,0.55,0.42,0.78,0.62,0.9,0.7)
    $baseY = [int]($h*0.62); $baseX = [int]($w*0.18)
    for ($i=0; $i -lt $vals.Count; $i++) {
        $bh = [int]($h*0.35*$vals[$i])
        $g.FillRectangle($bar, $baseX + $i*70, $baseY-$bh, 36, $bh)
    }
    # sparkline
    $line = New-PenC 220 80 230 255 2.5
    $prev = [System.Drawing.Point]::new([int]($w*0.55), [int]($h*0.45))
    $pts = @(0.3,0.5,0.35,0.65,0.55,0.8,0.7)
    for ($i=0; $i -lt $pts.Count; $i++) {
        $p = [System.Drawing.Point]::new([int]($w*0.55 + $i*40), [int]($h*(0.55 - $pts[$i]*0.25)))
        $g.DrawLine($line, $prev, $p); $prev = $p
    }
    $panel.Dispose(); $border.Dispose(); $bar.Dispose(); $line.Dispose()
}

function Draw-Shield($g, $w, $h) {
    $cx = [int]($w*0.5); $cy = [int]($h*0.38)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddPolygon(@(
        [System.Drawing.Point]::new($cx, $cy-110),
        [System.Drawing.Point]::new($cx+90, $cy-70),
        [System.Drawing.Point]::new($cx+85, $cy+40),
        [System.Drawing.Point]::new($cx, $cy+120),
        [System.Drawing.Point]::new($cx-85, $cy+40),
        [System.Drawing.Point]::new($cx-90, $cy-70)
    ))
    $fill = New-Brush 90 0 180 160
    $g.FillPath($fill, $path)
    $pen = New-PenC 220 80 255 220 3
    $g.DrawPath($pen, $path)
    $lock = New-Brush 230 230 255 255
    $g.FillRectangle($lock, $cx-18, $cy-5, 36, 40)
    $g.DrawArc((New-PenC 230 230 255 255 4), $cx-22, $cy-35, 44, 40, 200, 140)
    $fill.Dispose(); $pen.Dispose(); $lock.Dispose(); $path.Dispose()
}

function Draw-Health($g, $w, $h) {
    $cx = [int]($w*0.5); $cy = [int]($h*0.38)
    $cross = New-Brush 200 0 220 200
    $g.FillRectangle($cross, $cx-18, $cy-90, 36, 180)
    $g.FillRectangle($cross, $cx-70, $cy-18, 140, 36)
    $pulse = New-PenC 220 80 255 220 3
    $y = [int]($h*0.68)
    $g.DrawLines($pulse, @(
        [System.Drawing.Point]::new([int]($w*0.15), $y),
        [System.Drawing.Point]::new([int]($w*0.35), $y),
        [System.Drawing.Point]::new([int]($w*0.4), $y-40),
        [System.Drawing.Point]::new([int]($w*0.45), $y+35),
        [System.Drawing.Point]::new([int]($w*0.5), $y-55),
        [System.Drawing.Point]::new([int]($w*0.55), $y+10),
        [System.Drawing.Point]::new([int]($w*0.85), $y)
    ))
    $cross.Dispose(); $pulse.Dispose()
}

function Draw-Factory($g, $w, $h) {
    $build = New-Brush 80 40 50 70
    $accent = New-Brush 180 255 160 60
    $g.FillRectangle($build, [int]($w*0.15), [int]($h*0.35), [int]($w*0.55), [int]($h*0.35))
    # chimneys
    $g.FillRectangle($build, [int]($w*0.22), [int]($h*0.18), 28, [int]($h*0.2))
    $g.FillRectangle($build, [int]($w*0.35), [int]($h*0.22), 28, [int]($h*0.16))
    # gear
    $cx=[int]($w*0.78); $cy=[int]($h*0.42)
    $gear = New-PenC 200 255 180 80 4
    $g.DrawEllipse($gear, $cx-50, $cy-50, 100, 100)
    $g.DrawEllipse($gear, $cx-20, $cy-20, 40, 40)
    for ($i=0; $i -lt 8; $i++) {
        $ang = $i * [Math]::PI/4
        $x1 = $cx + [int](35*[Math]::Cos($ang)); $y1 = $cy + [int](35*[Math]::Sin($ang))
        $x2 = $cx + [int](60*[Math]::Cos($ang)); $y2 = $cy + [int](60*[Math]::Sin($ang))
        $g.DrawLine($gear, $x1, $y1, $x2, $y2)
    }
    $g.FillRectangle($accent, [int]($w*0.2), [int]($h*0.55), 40, 12)
    $g.FillRectangle($accent, [int]($w*0.28), [int]($h*0.55), 40, 12)
    $build.Dispose(); $accent.Dispose(); $gear.Dispose()
}

function Draw-Code($g, $w, $h) {
    $panel = New-Brush 90 8 16 28
    $g.FillRectangle($panel, [int]($w*0.12), [int]($h*0.14), [int]($w*0.76), [int]($h*0.58))
    $lines = @(
        @("public class Platform {", 0,220,140),
        @("  @Service", 80,230,255),
        @("  void scale() {", 200,200,220),
        @("    cloud.deploy(region);", 255,200,100),
        @("    observe(metrics);", 180,160,255),
        @("  }", 200,200,220),
        @("}", 0,220,140)
    )
    $font = New-Object System.Drawing.Font("Consolas", 18, [System.Drawing.FontStyle]::Regular)
    $y = [int]($h*0.2)
    foreach ($ln in $lines) {
        $br = New-Brush 230 $ln[1] $ln[2] $ln[3]
        $g.DrawString($ln[0], $font, $br, [int]($w*0.16), $y)
        $br.Dispose(); $y += 36
    }
    $panel.Dispose(); $font.Dispose()
}

function Draw-Banking($g, $w, $h) {
    $cx=[int]($w*0.32); $cy=[int]($h*0.4)
    $col = New-Brush 100 0 140 220
    $g.FillRectangle($col, $cx-70, $cy-40, 140, 130)
    $g.FillPolygon($col, @(
        [System.Drawing.Point]::new($cx-90,$cy-40),
        [System.Drawing.Point]::new($cx,$cy-100),
        [System.Drawing.Point]::new($cx+90,$cy-40)
    ))
    for ($i=0; $i -lt 4; $i++) {
        $pillar = New-Brush 160 200 230 255
        $g.FillRectangle($pillar, $cx-50+$i*28, $cy-20, 14, 90)
        $pillar.Dispose()
    }
    $col.Dispose()
    # right-side growth chart
    $bar = New-Brush 180 0 188 242
    $baseY = [int]($h*0.62); $baseX = [int]($w*0.58)
    $vals = @(0.4,0.55,0.5,0.75,0.9)
    for ($i=0; $i -lt $vals.Count; $i++) {
        $bh = [int]($h*0.32*$vals[$i])
        $g.FillRectangle($bar, $baseX + $i*48, $baseY-$bh, 28, $bh)
    }
    $bar.Dispose()
}

function Draw-Theme($g, $w, $h, $theme) {
    switch ($theme) {
        'ai' { Draw-Neural $g $w $h }
        'cloud' { Draw-CloudInfra $g $w $h }
        'security' { Draw-Shield $g $w $h }
        'health' { Draw-Health $g $w $h }
        'factory' { Draw-Factory $g $w $h }
        'data' { Draw-Dashboard $g $w $h }
        'code' { Draw-Code $g $w $h }
        'banking' { Draw-Banking $g $w $h }
        default { Draw-Dashboard $g $w $h }
    }
}

function New-TaggedImage($path, $title, $subtitle, $theme, $w, $h) {
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $g.InterpolationMode = 'HighQualityBicubic'

    Fill-Base $g $w $h $theme
    Draw-Theme $g $w $h $theme

    # bottom label bar
    $bar = New-Brush 170 4 8 18
    $g.FillRectangle($bar, 0, $h-110, $w, 110)
    $bar.Dispose()
    $accent = New-Brush 220 0 188 242
    $g.FillRectangle($accent, 0, $h-112, $w, 3)
    $accent.Dispose()

    $titleFont = New-Object System.Drawing.Font("Segoe UI", [Math]::Max(18, [int]($w/28)), [System.Drawing.FontStyle]::Bold)
    $subFont = New-Object System.Drawing.Font("Segoe UI", [Math]::Max(11, [int]($w/42)), [System.Drawing.FontStyle]::Regular)
    $white = New-Brush 250 245 252 255
    $cyan = New-Brush 230 80 230 255
    $g.DrawString($title, $titleFont, $white, 36, ($h - 92))
    if ($subtitle) { $g.DrawString($subtitle, $subFont, $cyan, 36, ($h - 52)) }

    $g.Dispose(); $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Jpeg); $bmp.Dispose()
    Write-Host "Created $path [$theme]"
}

# ---- Services ----
$map = @(
    @("services\enterprise-software-development.jpg","Enterprise Software","Custom Platforms | Architecture","code",1200,675),
    @("services\ai-solutions.jpg","AI Solutions","Neural Networks | Copilots","ai",1200,675),
    @("services\cloud-engineering.jpg","Cloud Engineering","AWS | Azure | Kubernetes","cloud",1200,675),
    @("services\devops.jpg","DevOps & CI/CD","Pipelines | Automation","cloud",1200,675),
    @("services\platform-engineering.jpg","Platform Engineering","Developer Platforms","code",1200,675),
    @("services\microservices.jpg","Microservices","Distributed Systems","code",1200,675),
    @("services\api-integration.jpg","API Integration","Enterprise Connectivity","data",1200,675),
    @("services\application-modernization.jpg","App Modernization","Legacy to Cloud","cloud",1200,675),
    @("services\observability.jpg","Observability","Metrics | Logs | Traces","data",1200,675),
    @("services\cyber-security.jpg","Cyber Security","Secure by Design","security",1200,675),
    @("services\performance-engineering.jpg","Performance Engineering","Scale | Reliability","data",1200,675),
    @("services\application-support.jpg","Application Support","Production Operations","cloud",1200,675),
    @("industries\banking.jpg","Banking","Digital Banking Platforms","banking",1200,675),
    @("industries\healthcare.jpg","Healthcare","Clinical & Operations Systems","health",1200,675),
    @("industries\insurance.jpg","Insurance","Claims | Policy Platforms","data",1200,675),
    @("industries\government.jpg","Government","Citizen Digital Services","cloud",1200,675),
    @("industries\manufacturing.jpg","Manufacturing","Industry 4.0 Operations","factory",1200,675),
    @("industries\retail.jpg","Retail","Omnichannel Commerce","data",1200,675),
    @("industries\telecom.jpg","Telecom","Customer Experience Platforms","cloud",1200,675),
    @("industries\education.jpg","Education","Campus & Learning Systems","ai",1200,675),
    @("blogs\ai.jpg","Enterprise AI","Private Copilots & Search","ai",1200,675),
    @("blogs\cloud.jpg","Cloud Strategy","Migration Without Disruption","cloud",1200,675),
    @("blogs\java.jpg","Java at Scale","Enterprise Application Design","code",1200,675),
    @("blogs\spring-boot.jpg","Spring Boot","Production Microservices","code",1200,675),
    @("blogs\devops.jpg","DevOps Delivery","CI/CD Excellence","cloud",1200,675),
    @("blogs\monitoring.jpg","Observability","Operational Intelligence","data",1200,675),
    @("blogs\security.jpg","Secure Engineering","Threat-Aware Delivery","security",1200,675),
    @("blogs\architecture.jpg","Architecture","Enterprise Patterns","code",1200,675),
    @("portfolio\enterprise-banking.jpg","Digital Banking","Transformation Scenario","banking",1200,675),
    @("portfolio\ai-chatbot.jpg","AI Knowledge","Assistants & Search","ai",1200,675),
    @("portfolio\cloud-migration.jpg","Cloud Migration","Program Scenario","cloud",1200,675),
    @("portfolio\monitoring-dashboard.jpg","Enterprise Monitoring","Observability Scenario","data",1200,675),
    @("portfolio\devops-automation.jpg","Workflow Automation","Process Scenario","code",1200,675),
    @("portfolio\microservices-platform.jpg","Platform Delivery","Architecture Scenario","code",1200,675),
    @("hero\hero-main.jpg","INFRALYTIX TECHNOLOGIES","Intelligent Digital Solutions","ai",1920,1080),
    @("about\about-hero.jpg","Enterprise Innovation","AI | Cloud | Automation","cloud",1400,900),
    @("team\pramod-kadam.jpg","PRAMOD KADAM","Founder & Technical Director","default",600,750)
)

foreach ($item in $map) {
    New-TaggedImage (Join-Path $root $item[0]) $item[1] $item[2] $item[3] $item[4] $item[5]
}

# Technologies - compact branded tiles
$techTheme = @{
    "java.jpg"="code"; "spring-boot.jpg"="code"; "react.jpg"="code"; "angular.jpg"="code"; "python.jpg"="ai"
    "aws.jpg"="cloud"; "azure.jpg"="cloud"; "docker.jpg"="cloud"; "kubernetes.jpg"="cloud"; "kafka.jpg"="data"
    "redis.jpg"="data"; "oracle.jpg"="data"; "mongodb.jpg"="data"; "postgresql.jpg"="data"
    "grafana.jpg"="data"; "prometheus.jpg"="data"; "opentelemetry.jpg"="data"
    "github.jpg"="code"; "gitlab.jpg"="code"; "jenkins.jpg"="cloud"
}
foreach ($k in $techTheme.Keys) {
    $name = ($k -replace '\.jpg$','' -replace '-',' ')
    $name = (Get-Culture).TextInfo.ToTitleCase($name)
    if ($name -eq 'Postgresql') { $name = 'PostgreSQL' }
    if ($name -eq 'Opentelemetry') { $name = 'OpenTelemetry' }
    if ($name -eq 'Aws') { $name = 'AWS' }
    New-TaggedImage (Join-Path $root "technologies\$k") $name "Enterprise Technology" $techTheme[$k] 800 500
}

# Page heroes
Copy-Item (Join-Path $root "hero\hero-main.jpg") (Join-Path $root "pages\home.jpg") -Force
Copy-Item (Join-Path $root "services\cloud-engineering.jpg") (Join-Path $root "pages\services.jpg") -Force
Copy-Item (Join-Path $root "about\about-hero.jpg") (Join-Path $root "pages\about.jpg") -Force
Copy-Item (Join-Path $root "technologies\java.jpg") (Join-Path $root "pages\technologies.jpg") -Force
Copy-Item (Join-Path $root "industries\banking.jpg") (Join-Path $root "pages\industries.jpg") -Force
Copy-Item (Join-Path $root "portfolio\enterprise-banking.jpg") (Join-Path $root "pages\portfolio.jpg") -Force
Copy-Item (Join-Path $root "blogs\ai.jpg") (Join-Path $root "pages\blogs.jpg") -Force
Copy-Item (Join-Path $root "team\pramod-kadam.jpg") (Join-Path $root "pages\careers.jpg") -Force
Copy-Item (Join-Path $root "hero\hero-main.jpg") (Join-Path $root "pages\contact.jpg") -Force
Copy-Item (Join-Path $root "services\ai-solutions.jpg") (Join-Path $root "pages\solutions.jpg") -Force
Copy-Item (Join-Path $root "services\cyber-security.jpg") (Join-Path $root "pages\privacy.jpg") -Force
Copy-Item (Join-Path $root "services\observability.jpg") (Join-Path $root "pages\terms.jpg") -Force

Write-Host "All topic-specific images generated."
