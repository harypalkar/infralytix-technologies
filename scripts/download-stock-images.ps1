# Download colorful, topic-specific Unsplash photos (free to use) for site cards.
# Replaces generic cube/network generated placeholders.
$ErrorActionPreference = "Stop"
$root = "d:\Harish nilam medical documents\pandit doctor receipt (1)\harish\infralytix-technologies\src\main\resources\static\images"
$dirs = @("hero","services","industries","technologies","blogs","portfolio","about","team","pages")
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path (Join-Path $root $d) | Out-Null }

function Get-Photo([string]$relPath, [string]$photoId, [int]$w = 1200, [int]$h = 675) {
    $out = Join-Path $root $relPath
    $url = "https://images.unsplash.com/$photoId`?auto=format&fit=crop&w=$w&h=$h&q=80"
    Write-Host "Downloading $relPath ..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -TimeoutSec 60
    } catch {
        Write-Warning "Failed $relPath : $($_.Exception.Message)"
    }
}

# --- Services (colorful, real photography) ---
Get-Photo "services/enterprise-software-development.jpg" "photo-1555066931-4365d14bab8c"   # code
Get-Photo "services/ai-solutions.jpg" "photo-1677442136019-21780ecad995"                 # AI abstract
Get-Photo "services/cloud-engineering.jpg" "photo-1451187580459-43490279c0fa"            # earth/cloud tech
Get-Photo "services/devops.jpg" "photo-1667372393119-3d4c48d07fc9"                       # containers/devops
Get-Photo "services/platform-engineering.jpg" "photo-1518770660439-4636190af475"         # circuit board
Get-Photo "services/microservices.jpg" "photo-1558494949-ef010cbdcc31"                   # server room
Get-Photo "services/api-integration.jpg" "photo-1555949963-aa79dcee981c"                 # coding API
Get-Photo "services/application-modernization.jpg" "photo-1460925895917-afdab827c52f"   # analytics desk
Get-Photo "services/observability.jpg" "photo-1551288049-bebda4e38f71"                   # colorful dashboard
Get-Photo "services/cyber-security.jpg" "photo-1563986768609-322da13575f3"               # security lock
Get-Photo "services/performance-engineering.jpg" "photo-1504868584819-f8e8b4b6d7e3"     # charts
Get-Photo "services/application-support.jpg" "photo-1522071820081-009f0129c71c"          # team support

# --- Industries ---
Get-Photo "industries/banking.jpg" "photo-1556742049-0cfed4f6a45d"                       # finance
Get-Photo "industries/healthcare.jpg" "photo-1576091160399-112ba8d25d1d"                 # healthcare
Get-Photo "industries/insurance.jpg" "photo-1450101499163-c8848c66ca85"                  # documents/business
Get-Photo "industries/government.jpg" "photo-1529107386315-e1a2ed48a620"                 # civic/architecture
Get-Photo "industries/manufacturing.jpg" "photo-1581091226825-a6a2a5aee158"              # factory
Get-Photo "industries/retail.jpg" "photo-1441986300917-64674bd600d8"                     # retail
Get-Photo "industries/telecom.jpg" "photo-1516321318423-f06f85e504b3"                    # network/tech
Get-Photo "industries/education.jpg" "photo-1503676260728-1c00da094a0b"                  # education / learning

# --- Blogs ---
Get-Photo "blogs/ai.jpg" "photo-1620712943543-bcc4688e7485"                              # AI robot
Get-Photo "blogs/cloud.jpg" "photo-1451187580459-43490279c0fa"                          # earth from space / cloud tech
Get-Photo "blogs/java.jpg" "photo-1515879218367-8466d910aaa4"                            # code screen
Get-Photo "blogs/spring-boot.jpg" "photo-1498050108023-c5249f4df085"                     # laptop code
Get-Photo "blogs/devops.jpg" "photo-1605745341112-85968b19335b"                          # pipelines feel
Get-Photo "blogs/monitoring.jpg" "photo-1551288049-bebda4e38f71"                         # monitoring dashboard
Get-Photo "blogs/security.jpg" "photo-1550751827-4bd374c3f58b"                           # cybersecurity
Get-Photo "blogs/architecture.jpg" "photo-1486312338219-ce68d2c6f44d"                    # architecture work

# --- Case studies / portfolio ---
Get-Photo "portfolio/enterprise-banking.jpg" "photo-1563013544-824ae1b704d3"             # banking cards
Get-Photo "portfolio/ai-chatbot.jpg" "photo-1531746790731-6c087fecd65a"                  # AI interaction
Get-Photo "portfolio/cloud-migration.jpg" "photo-1518770660439-4636190af475"             # circuit / cloud tech
Get-Photo "portfolio/monitoring-dashboard.jpg" "photo-1460925895917-afdab827c52f"        # dashboard analytics
Get-Photo "portfolio/devops-automation.jpg" "photo-1518186285589-2f7649de83e0"           # automation data
Get-Photo "portfolio/microservices-platform.jpg" "photo-1558494949-ef010cbdcc31"         # servers

# --- Technologies (square-ish colorful) ---
$techs = @{
    "java.jpg"="photo-1515879218367-8466d910aaa4"
    "spring-boot.jpg"="photo-1498050108023-c5249f4df085"
    "react.jpg"="photo-1633356122544-f134324a6cee"
    "angular.jpg"="photo-1593720213428-28a5b9e94613"
    "python.jpg"="photo-1526374965328-7f61d4dc18c5"
    "aws.jpg"="photo-1451187580459-43490279c0fa"
    "azure.jpg"="photo-1639322537228-f710d846310a"
    "docker.jpg"="photo-1605745341112-85968b19335b"
    "kubernetes.jpg"="photo-1667372393119-3d4c48d07fc9"
    "kafka.jpg"="photo-1558494949-ef010cbdcc31"
    "redis.jpg"="photo-1555066931-4365d14bab8c"
    "oracle.jpg"="photo-1544383835-bda2bc66a55d"
    "mongodb.jpg"="photo-1544383835-bda2bc66a55d"
    "postgresql.jpg"="photo-1544383835-bda2bc66a55d"
    "grafana.jpg"="photo-1551288049-bebda4e38f71"
    "prometheus.jpg"="photo-1504868584819-f8e8b4b6d7e3"
    "opentelemetry.jpg"="photo-1460925895917-afdab827c52f"
    "github.jpg"="photo-1555066931-4365d14bab8c"
    "gitlab.jpg"="photo-1556075798-4825dfaaf498"
    "jenkins.jpg"="photo-1518186285589-2f7649de83e0"
}
foreach ($k in $techs.Keys) {
    Get-Photo "technologies\$k" $techs[$k] 800 500
}

# --- Hero / about / pages ---
Get-Photo "hero/hero-main.jpg" "photo-1451187580459-43490279c0fa" 1920 1080
Get-Photo "about/about-hero.jpg" "photo-1522071820081-009f0129c71c" 1400 900
# Keep team portrait path but use professional office portrait stock (not fake named person face claim)
Get-Photo "team/pramod-kadam.jpg" "photo-1560250097-0b93528c311a" 600 750

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

Write-Host "Stock images downloaded."
