# Direct PowerShell Script to Add ALL Properties
# Connects directly to the known Umbraco URL

$baseUrl = "https://localhost:44357"
$documentTypeId = "3c26f5ee-3eac-4c22-bbd4-7a37680ac91b"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Adding ALL Editable Properties via API" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Skip SSL certificate validation for localhost
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "1. Getting document type details..." -ForegroundColor Yellow
try {
    $docTypeDetails = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Method Get
    Write-Host "   Found: $($docTypeDetails.name)" -ForegroundColor Green
    Write-Host "   Current properties: $($docTypeDetails.properties.Count)" -ForegroundColor Cyan
} catch {
    Write-Host "ERROR: Failed to get document type!" -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "2. Finding TextString data type..." -ForegroundColor Yellow
try {
    $allDataTypes = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/data-type" -Method Get
    $textStringDataType = $allDataTypes.items | Where-Object { $_.name -eq "Textstring" }
    
    if (-not $textStringDataType) {
        Write-Host "ERROR: TextString data type not found!" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "   Found: $($textStringDataType.name)" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to get data types!" -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# All new properties
$propertiesToAdd = @(
    @{ alias = "demoIframeUrl"; name = "Demo Iframe URL"; description = "URL for the hero demo iframe"; sortOrder = 100 }
    @{ alias = "primaryCtaText"; name = "Primary CTA Text"; description = "Text for primary CTA button"; sortOrder = 101 }
    @{ alias = "primaryCtaUrl"; name = "Primary CTA URL"; description = "URL for primary CTA button"; sortOrder = 102 }
    @{ alias = "secondaryCtaText"; name = "Secondary CTA Text"; description = "Text for secondary CTA button"; sortOrder = 103 }
    @{ alias = "secondaryCtaUrl"; name = "Secondary CTA URL"; description = "URL for secondary CTA button"; sortOrder = 104 }
    @{ alias = "logoText"; name = "Logo Text"; description = "Header logo text"; sortOrder = 200 }
    @{ alias = "navLink1Text"; name = "Nav Link 1 Text"; description = "Navigation link 1 text"; sortOrder = 201 }
    @{ alias = "navLink1Url"; name = "Nav Link 1 URL"; description = "Navigation link 1 URL"; sortOrder = 202 }
    @{ alias = "navLink2Text"; name = "Nav Link 2 Text"; description = "Navigation link 2 text"; sortOrder = 203 }
    @{ alias = "navLink2Url"; name = "Nav Link 2 URL"; description = "Navigation link 2 URL"; sortOrder = 204 }
    @{ alias = "navLink3Text"; name = "Nav Link 3 Text"; description = "Navigation link 3 text"; sortOrder = 205 }
    @{ alias = "navLink3Url"; name = "Nav Link 3 URL"; description = "Navigation link 3 URL"; sortOrder = 206 }
    @{ alias = "navLink4Text"; name = "Nav Link 4 Text"; description = "Navigation link 4 text"; sortOrder = 207 }
    @{ alias = "navLink4Url"; name = "Nav Link 4 URL"; description = "Navigation link 4 URL"; sortOrder = 208 }
    @{ alias = "ctaButtonText"; name = "Header CTA Button Text"; description = "Header CTA button text"; sortOrder = 209 }
    @{ alias = "servicesHeading"; name = "Services Heading"; description = "Services section heading"; sortOrder = 300 }
    @{ alias = "servicesSubheading"; name = "Services Subheading"; description = "Services section subheading"; sortOrder = 301 }
    @{ alias = "service1Title"; name = "Service 1 Title"; description = "Service card 1 title"; sortOrder = 302 }
    @{ alias = "service1Icon"; name = "Service 1 Icon"; description = "Service card 1 icon class"; sortOrder = 303 }
    @{ alias = "service1Description"; name = "Service 1 Description"; description = "Service card 1 description"; sortOrder = 304 }
    @{ alias = "service2Title"; name = "Service 2 Title"; description = "Service card 2 title"; sortOrder = 305 }
    @{ alias = "service2Icon"; name = "Service 2 Icon"; description = "Service card 2 icon class"; sortOrder = 306 }
    @{ alias = "service2Description"; name = "Service 2 Description"; description = "Service card 2 description"; sortOrder = 307 }
    @{ alias = "service3Title"; name = "Service 3 Title"; description = "Service card 3 title"; sortOrder = 308 }
    @{ alias = "service3Icon"; name = "Service 3 Icon"; description = "Service card 3 icon class"; sortOrder = 309 }
    @{ alias = "service3Description"; name = "Service 3 Description"; description = "Service card 3 description"; sortOrder = 310 }
    @{ alias = "service4Title"; name = "Service 4 Title"; description = "Service card 4 title"; sortOrder = 311 }
    @{ alias = "service4Icon"; name = "Service 4 Icon"; description = "Service card 4 icon class"; sortOrder = 312 }
    @{ alias = "service4Description"; name = "Service 4 Description"; description = "Service card 4 description"; sortOrder = 313 }
    @{ alias = "service5Title"; name = "Service 5 Title"; description = "Service card 5 title"; sortOrder = 314 }
    @{ alias = "service5Icon"; name = "Service 5 Icon"; description = "Service card 5 icon class"; sortOrder = 315 }
    @{ alias = "service5Description"; name = "Service 5 Description"; description = "Service card 5 description"; sortOrder = 316 }
    @{ alias = "service6Title"; name = "Service 6 Title"; description = "Service card 6 title"; sortOrder = 317 }
    @{ alias = "service6Icon"; name = "Service 6 Icon"; description = "Service card 6 icon class"; sortOrder = 318 }
    @{ alias = "service6Description"; name = "Service 6 Description"; description = "Service card 6 description"; sortOrder = 319 }
    @{ alias = "client1Name"; name = "Client 1 Name"; description = "Client logo 1 name"; sortOrder = 400 }
    @{ alias = "client2Name"; name = "Client 2 Name"; description = "Client logo 2 name"; sortOrder = 401 }
    @{ alias = "client3Name"; name = "Client 3 Name"; description = "Client logo 3 name"; sortOrder = 402 }
    @{ alias = "client4Name"; name = "Client 4 Name"; description = "Client logo 4 name"; sortOrder = 403 }
    @{ alias = "client5Name"; name = "Client 5 Name"; description = "Client logo 5 name"; sortOrder = 404 }
    @{ alias = "client6Name"; name = "Client 6 Name"; description = "Client logo 6 name"; sortOrder = 405 }
    @{ alias = "client7Name"; name = "Client 7 Name"; description = "Client logo 7 name"; sortOrder = 406 }
    @{ alias = "client8Name"; name = "Client 8 Name"; description = "Client logo 8 name"; sortOrder = 407 }
)

Write-Host ""
Write-Host "3. Adding $($propertiesToAdd.Count) new properties..." -ForegroundColor Yellow
$existingAliases = $docTypeDetails.properties | ForEach-Object { $_.alias }
$addedCount = 0
$skippedCount = 0

foreach ($prop in $propertiesToAdd) {
    if ($existingAliases -contains $prop.alias) {
        Write-Host "   - Skipping: $($prop.name)" -ForegroundColor Gray
        $skippedCount++
        continue
    }
    
    $newProperty = @{
        id = [Guid]::NewGuid().ToString()
        container = @{ id = $docTypeDetails.containers[0].id }
        sortOrder = $prop.sortOrder
        alias = $prop.alias
        name = $prop.name
        description = $prop.description
        dataType = @{ id = $textStringDataType.id }
        variesByCulture = $false
        variesBySegment = $false
        validation = @{
            mandatory = $false
            mandatoryMessage = $null
            regEx = $null
            regExMessage = $null
        }
        appearance = @{
            labelOnTop = $false
        }
    }
    
    $docTypeDetails.properties += $newProperty
    Write-Host "   + Added: $($prop.name)" -ForegroundColor Green
    $addedCount++
}

Write-Host ""
Write-Host "4. Saving changes to Umbraco..." -ForegroundColor Yellow
$jsonBody = $docTypeDetails | ConvertTo-Json -Depth 10
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Method Put -Body $jsonBody -ContentType "application/json"
    Write-Host "   SUCCESS! Document type updated" -ForegroundColor Green
} catch {
    Write-Host "   ERROR: Failed to update" -ForegroundColor Red
    Write-Host "   $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "COMPLETE!" -ForegroundColor Green
Write-Host "Added: $addedCount properties" -ForegroundColor Green
Write-Host "Skipped: $skippedCount properties" -ForegroundColor Yellow
Write-Host "Total: $($propertiesToAdd.Count) properties" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Now you can edit in Umbraco backoffice:" -ForegroundColor Yellow
Write-Host "- All 6 service cards (title, icon, description)" -ForegroundColor White
Write-Host "- Header navigation (logo, 4 menu links, CTA)" -ForegroundColor White
Write-Host "- Hero section (iframe URL, 2 CTA buttons)" -ForegroundColor White
Write-Host "- All 8 client logos" -ForegroundColor White
