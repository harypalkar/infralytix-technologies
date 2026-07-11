# Export Spring Boot Thymeleaf site to static HTML for Vercel deployment
param(
    [int]$Port = 8099,
    [string]$WebsiteUrl = "https://infralytix.in",
    [switch]$SkipServerStart
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
$publicDir = Join-Path $projectRoot "public"
$staticSrc = Join-Path $projectRoot "src\main\resources\static"
$jarPath = Join-Path $projectRoot "target\infralytix-technologies.jar"
$javaExe = if ($env:JAVA_HOME) { Join-Path $env:JAVA_HOME "bin\java.exe" } else { "java" }

if (-not (Test-Path $jarPath)) {
    Write-Host "Building JAR first..."
    Push-Location $projectRoot
    if (-not $env:JAVA_HOME) { $env:JAVA_HOME = "C:\Program Files\Java\jdk-21.0.11" }
    $javaExe = Join-Path $env:JAVA_HOME "bin\java.exe"
    & .\mvnw.cmd clean package -DskipTests -B -q
    Pop-Location
}

if (-not (Test-Path (Join-Path $staticSrc "images\logo.png"))) {
    Write-Host "Generating images..."
    & (Join-Path $projectRoot "scripts\generate-premium-images.ps1")
}

Write-Host "Preparing public directory..."
if (Test-Path $publicDir) { Remove-Item $publicDir -Recurse -Force }
New-Item -ItemType Directory -Path $publicDir | Out-Null
Copy-Item -Path "$staticSrc\*" -Destination $publicDir -Recurse -Force

$routes = [ordered]@{
    "/"             = "index.html"
    "/about"        = "about.html"
    "/services"     = "services.html"
    "/solutions"    = "solutions.html"
    "/technologies" = "technologies.html"
    "/industries"   = "industries.html"
    "/portfolio"    = "portfolio.html"
    "/blogs"        = "blogs.html"
    "/careers"      = "careers.html"
    "/contact"      = "contact.html"
    "/privacy"      = "privacy.html"
    "/terms"        = "terms.html"
}

$javaProcess = $null
if (-not $SkipServerStart) {
    Write-Host "Starting Spring Boot on port $Port..."
    $env:SPRING_PROFILES_ACTIVE = "dev"
    $javaProcess = Start-Process -FilePath $javaExe `
        -ArgumentList "-jar", "`"$jarPath`"", "--server.port=$Port" `
        -PassThru -WindowStyle Hidden
}

try {
    $healthUrl = "http://localhost:$Port/actuator/health"
    $ready = $false
    for ($i = 0; $i -lt 90; $i++) {
        try {
            $null = Invoke-WebRequest -Uri $healthUrl -UseBasicParsing -TimeoutSec 5
            $ready = $true
            break
        } catch { Start-Sleep -Seconds 2 }
    }
    if (-not $ready) { throw "Spring Boot did not become healthy on port $Port." }

    Write-Host "Exporting pages..."
    foreach ($entry in $routes.GetEnumerator()) {
        $url = "http://localhost:$Port$($entry.Key)"
        $outFile = Join-Path $publicDir $entry.Value
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing
        [System.IO.File]::WriteAllText($outFile, $response.Content, [System.Text.UTF8Encoding]::new($false))
        Write-Host "  $($entry.Value)"
    }

    $notFound = (Invoke-WebRequest -Uri "http://localhost:$Port/__static_export_404__" -UseBasicParsing).Content
    [System.IO.File]::WriteAllText((Join-Path $publicDir "404.html"), $notFound, [System.Text.UTF8Encoding]::new($false))
    Write-Host "  404.html"

    $contactFile = Join-Path $publicDir "contact.html"
    $contactHtml = Get-Content $contactFile -Raw
    $contactHtml = $contactHtml -replace '<form action="/contact" method="post">', @"
<form action="https://formsubmit.co/contact@infralytix.in" method="POST">
                    <input type="hidden" name="_subject" value="INFRALYTIX Contact Form"/>
                    <input type="hidden" name="_captcha" value="false"/>
                    <input type="hidden" name="_template" value="table"/>
                    <input type="text" name="_honey" style="display:none" tabindex="-1" autocomplete="off"/>
                    <input type="hidden" name="_next" value="$WebsiteUrl/contact?sent=true"/>
"@
    $successBanner = '<div id="formSuccess" class="alert alert-success" style="display:none;">Thank you! Your message has been sent successfully. We will get back to you soon.</div>'
    if ($contactHtml -notmatch 'id="formSuccess"') {
        $contactHtml = $contactHtml -replace '<div class="contact-grid">', "$successBanner`n`n        <div class=`"contact-grid`">"
    }
    $contactHtml = $contactHtml -replace '</body>', @"
<script>
if (new URLSearchParams(window.location.search).get('sent') === 'true') {
  var el = document.getElementById('formSuccess');
  if (el) { el.style.display = 'block'; }
}
</script>
</body>
"@
    [System.IO.File]::WriteAllText($contactFile, $contactHtml, [System.Text.UTF8Encoding]::new($false))

    Write-Host "Static export complete: $publicDir"
} finally {
    if ($javaProcess -and -not $javaProcess.HasExited) {
        Stop-Process -Id $javaProcess.Id -Force -ErrorAction SilentlyContinue
    }
}
