# Serve the static Vercel site locally for preview
param(
    [int]$Port = 3000,
    [string]$Root = (Join-Path (Split-Path -Parent $PSScriptRoot) "public")
)

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".webp" = "image/webp"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".txt"  = "text/plain; charset=utf-8"
    ".xml"  = "application/xml; charset=utf-8"
}

function Get-LocalPath([string]$urlPath) {
    $path = [System.Uri]::UnescapeDataString($urlPath.TrimStart('/'))
    if ([string]::IsNullOrWhiteSpace($path)) { $path = "index.html" }
    if ($path.EndsWith("/")) { $path += "index.html" }
    if (-not (Get-ChildItem -LiteralPath $Root -Filter (Split-Path $path -Leaf) -ErrorAction SilentlyContinue) -and
        -not (Test-Path -LiteralPath (Join-Path $Root $path))) {
        $withHtml = "$path.html"
        if (Test-Path -LiteralPath (Join-Path $Root $withHtml)) { return Join-Path $Root $withHtml }
    }
    Join-Path $Root $path
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Static site running at http://localhost:$Port/"
Write-Host "Serving: $Root"
Write-Host "Press Ctrl+C to stop."

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        $localPath = Get-LocalPath $request.Url.LocalPath

        if (-not (Test-Path -LiteralPath $localPath) -or (Get-Item -LiteralPath $localPath).PSIsContainer) {
            $localPath = Join-Path $Root "404.html"
            $response.StatusCode = 404
        }

        $ext = [System.IO.Path]::GetExtension($localPath).ToLowerInvariant()
        $contentType = $mimeTypes[$ext]
        if (-not $contentType) { $contentType = "application/octet-stream" }

        $bytes = [System.IO.File]::ReadAllBytes($localPath)
        $response.ContentType = $contentType
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
        $response.OutputStream.Close()
    }
} finally {
    $listener.Stop()
    $listener.Close()
}
