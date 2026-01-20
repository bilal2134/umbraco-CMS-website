# PowerShell Script to Add ALL Editable Properties to BPO Homepage Document Type
# This makes the entire website editable from Umbraco backoffice

# Try both possible URLs
$possibleUrls = @("https://localhost:44357", "http://localhost:5000")
$baseUrl = $null

foreach ($url in $possibleUrls) {
    try {
        $testResponse = Invoke-WebRequest -Uri "$url/umbraco" -Method Head -TimeoutSec 2 -ErrorAction Stop
        $baseUrl = $url
        Write-Host "✓ Found Umbraco at: $baseUrl" -ForegroundColor Green
        break
    } catch {
        # Continue to next URL
    }
}

if (-not $baseUrl) {
    Write-Host "ERROR: Umbraco server is not running!" -ForegroundColor Red
    Write-Host "Please start Umbraco first:" -ForegroundColor Yellow
    Write-Host "  cd UmbracoAIChatbot" -ForegroundColor White
    Write-Host "  dotnet run" -ForegroundColor White
    exit 1
}

$documentTypeName = "BPO Homepage Complete"
$documentTypeId = "3c26f5ee-3eac-4c22-bbd4-7a37680ac91b"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Adding ALL Editable Properties to Document Type" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Get the document type details directly using known ID
Write-Host "1. Getting document type details..." -ForegroundColor Yellow
try {
    $docTypeDetails = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Method Get
    Write-Host "   Found: $($docTypeDetails.name)" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to get document type details!" -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Find TextString data type
Write-Host "`n2. Finding TextString data type..." -ForegroundColor Yellow
try {
    $allDataTypes = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/data-type" -Method Get
    $textStringDataType = $allDataTypes.items | Where-Object { $_.name -eq "Textstring" }
    
    if (-not $textStringDataType) {
        Write-Host "ERROR: TextString data type not found!" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "   Found: $($textStringDataType.name) (ID: $($textStringDataType.id))" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to get data types!" -ForegroundColor Red
    Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Define ALL properties to add
$propertiesToAdd = @(
    # IFRAME
    @{ alias = "demoIframeUrl"; name = "Demo Iframe URL"; description = "URL for the hero demo iframe"; sortOrder = 100 }
    
    # PRIMARY & SECONDARY CTAs
    @{ alias = "primaryCtaText"; name = "Primary CTA Text"; description = "Text for primary call-to-action button"; sortOrder = 101 }
    @{ alias = "primaryCtaUrl"; name = "Primary CTA URL"; description = "URL for primary call-to-action button"; sortOrder = 102 }
    @{ alias = "secondaryCtaText"; name = "Secondary CTA Text"; description = "Text for secondary call-to-action button"; sortOrder = 103 }
    @{ alias = "secondaryCtaUrl"; name = "Secondary CTA URL"; description = "URL for secondary call-to-action button"; sortOrder = 104 }
    
    # HEADER/NAVIGATION
    @{ alias = "logoText"; name = "Logo Text"; description = "Text for the header logo"; sortOrder = 200 }
    @{ alias = "navLink1Text"; name = "Nav Link 1 Text"; description = "Text for navigation link 1"; sortOrder = 201 }
    @{ alias = "navLink1Url"; name = "Nav Link 1 URL"; description = "URL for navigation link 1"; sortOrder = 202 }
    @{ alias = "navLink2Text"; name = "Nav Link 2 Text"; description = "Text for navigation link 2"; sortOrder = 203 }
    @{ alias = "navLink2Url"; name = "Nav Link 2 URL"; description = "URL for navigation link 2"; sortOrder = 204 }
    @{ alias = "navLink3Text"; name = "Nav Link 3 Text"; description = "Text for navigation link 3"; sortOrder = 205 }
    @{ alias = "navLink3Url"; name = "Nav Link 3 URL"; description = "URL for navigation link 3"; sortOrder = 206 }
    @{ alias = "navLink4Text"; name = "Nav Link 4 Text"; description = "Text for navigation link 4"; sortOrder = 207 }
    @{ alias = "navLink4Url"; name = "Nav Link 4 URL"; description = "URL for navigation link 4"; sortOrder = 208 }
    @{ alias = "ctaButtonText"; name = "Header CTA Button Text"; description = "Text for header CTA button"; sortOrder = 209 }
    
    # SERVICES SECTION
    @{ alias = "servicesHeading"; name = "Services Heading"; description = "Main heading for services section"; sortOrder = 300 }
    @{ alias = "servicesSubheading"; name = "Services Subheading"; description = "Subheading for services section"; sortOrder = 301 }
    
    # SERVICE CARD 1
    @{ alias = "service1Title"; name = "Service 1 Title"; description = "Title for service card 1"; sortOrder = 302 }
    @{ alias = "service1Icon"; name = "Service 1 Icon"; description = "FontAwesome icon class for service 1"; sortOrder = 303 }
    @{ alias = "service1Description"; name = "Service 1 Description"; description = "Description for service card 1"; sortOrder = 304 }
    
    # SERVICE CARD 2
    @{ alias = "service2Title"; name = "Service 2 Title"; description = "Title for service card 2"; sortOrder = 305 }
    @{ alias = "service2Icon"; name = "Service 2 Icon"; description = "FontAwesome icon class for service 2"; sortOrder = 306 }
    @{ alias = "service2Description"; name = "Service 2 Description"; description = "Description for service card 2"; sortOrder = 307 }
    
    # SERVICE CARD 3
    @{ alias = "service3Title"; name = "Service 3 Title"; description = "Title for service card 3"; sortOrder = 308 }
    @{ alias = "service3Icon"; name = "Service 3 Icon"; description = "FontAwesome icon class for service 3"; sortOrder = 309 }
    @{ alias = "service3Description"; name = "Service 3 Description"; description = "Description for service card 3"; sortOrder = 310 }
    
    # SERVICE CARD 4
    @{ alias = "service4Title"; name = "Service 4 Title"; description = "Title for service card 4"; sortOrder = 311 }
    @{ alias = "service4Icon"; name = "Service 4 Icon"; description = "FontAwesome icon class for service 4"; sortOrder = 312 }
    @{ alias = "service4Description"; name = "Service 4 Description"; description = "Description for service card 4"; sortOrder = 313 }
    
    # SERVICE CARD 5
    @{ alias = "service5Title"; name = "Service 5 Title"; description = "Title for service card 5"; sortOrder = 314 }
    @{ alias = "service5Icon"; name = "Service 5 Icon"; description = "FontAwesome icon class for service 5"; sortOrder = 315 }
    @{ alias = "service5Description"; name = "Service 5 Description"; description = "Description for service card 5"; sortOrder = 316 }
    
    # SERVICE CARD 6
    @{ alias = "service6Title"; name = "Service 6 Title"; description = "Title for service card 6"; sortOrder = 317 }
    @{ alias = "service6Icon"; name = "Service 6 Icon"; description = "FontAwesome icon class for service 6"; sortOrder = 318 }
    @{ alias = "service6Description"; name = "Service 6 Description"; description = "Description for service card 6"; sortOrder = 319 }
    
    # CLIENT LOGOS
    @{ alias = "client1Name"; name = "Client 1 Name"; description = "Name for client logo 1"; sortOrder = 400 }
    @{ alias = "client2Name"; name = "Client 2 Name"; description = "Name for client logo 2"; sortOrder = 401 }
    @{ alias = "client3Name"; name = "Client 3 Name"; description = "Name for client logo 3"; sortOrder = 402 }
    @{ alias = "client4Name"; name = "Client 4 Name"; description = "Name for client logo 4"; sortOrder = 403 }
    @{ alias = "client5Name"; name = "Client 5 Name"; description = "Name for client logo 5"; sortOrder = 404 }
    @{ alias = "client6Name"; name = "Client 6 Name"; description = "Name for client logo 6"; sortOrder = 405 }
    @{ alias = "client7Name"; name = "Client 7 Name"; description = "Name for client logo 7"; sortOrder = 406 }
    @{ alias = "client8Name"; name = "Client 8 Name"; description = "Name for client logo 8"; sortOrder = 407 }
)

Write-Host "`n3. Adding properties..." -ForegroundColor Yellow
$existingAliases = $docTypeDetails.properties | ForEach-Object { $_.alias }
$addedCount = 0
$skippedCount = 0

foreach ($prop in $propertiesToAdd) {
    if ($existingAliases -contains $prop.alias) {
        Write-Host "   ⊘ Skipping: $($prop.name) (already exists)" -ForegroundColor Gray
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

Write-Host "`n4. Updating document type..." -ForegroundColor Yellow
$jsonBody = $docTypeDetails | ConvertTo-Json -Depth 10
try {
    $updateResponse = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Method Put -Body $jsonBody -ContentType "application/json"
    Write-Host "   Document type updated successfully!" -ForegroundColor Green
} catch {
    Write-Host "   ERROR: Failed to update document type" -ForegroundColor Red
    Write-Host "   Details: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Added: $addedCount properties" -ForegroundColor Green
Write-Host "  Skipped: $skippedCount properties (already exist)" -ForegroundColor Yellow
Write-Host "  Total: $($propertiesToAdd.Count) properties processed" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "SUCCESS! All properties have been added to the document type." -ForegroundColor Green
Write-Host "You can now edit ALL website content from the Umbraco backoffice!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "  1. Go to Umbraco backoffice" -ForegroundColor White
Write-Host "  2. Edit your BPO Homepage document" -ForegroundColor White
Write-Host "  3. Fill in the new fields for services and navigation" -ForegroundColor White
Write-Host "  4. Save and publish" -ForegroundColor White
