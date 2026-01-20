# Add All 43 Properties to Document Type via Umbraco API
# This script automatically adds all editable properties

$baseUrl = "https://localhost:44357"
$clientId = "umbraco-back-office-1234566"
$clientSecret = "abcd123456"
$documentTypeId = "3c26f5ee-3eac-4c22-bbd4-7a37680ac91b"
$textstringId = "0cc0eba1-9960-42c9-bf9b-60e150b429ae"
$textareaId = "c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3"

Write-Host "`n=== Adding All 43 Properties to Document Type ===" -ForegroundColor Cyan

# Skip SSL validation
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

Write-Host "Getting OAuth token..." -ForegroundColor Yellow
$tokenBody = @{
    grant_type = "client_credentials"
    client_id = $clientId
    client_secret = $clientSecret
}
try {
    $tokenResponse = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/security/back-office/token" -Method Post -Body $tokenBody -ContentType "application/x-www-form-urlencoded"
    $token = $tokenResponse.access_token
    Write-Host "Token obtained!" -ForegroundColor Green
} catch {
    Write-Host "Failed to get token: $_" -ForegroundColor Red
    exit 1
}

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

Write-Host "Fetching current document type..." -ForegroundColor Yellow
try {
    $docType = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Headers $headers -Method Get
    Write-Host "Document type retrieved!" -ForegroundColor Green
} catch {
    Write-Host "Failed to get document type: $_" -ForegroundColor Red
    exit 1
}

# Create new tabs
$heroTabId = ($docType.containers | Where-Object { $_.name -eq "Hero Section" }).id
$aboutTabId = ($docType.containers | Where-Object { $_.name -eq "About Section" }).id
$contactTabId = ($docType.containers | Where-Object { $_.name -eq "Contact Section" }).id

$headerTabId = [Guid]::NewGuid().ToString()
$servicesTabId = [Guid]::NewGuid().ToString()
$clientsTabId = [Guid]::NewGuid().ToString()

$allContainers = @($docType.containers) + @(
    @{ id = $headerTabId; name = "Header Section"; parent = $null; sortOrder = 3; type = "Tab" }
    @{ id = $servicesTabId; name = "Services Section"; parent = $null; sortOrder = 4; type = "Tab" }
    @{ id = $clientsTabId; name = "Clients Section"; parent = $null; sortOrder = 5; type = "Tab" }
)

# Create all new properties
$newProperties = @($docType.properties) + @(
    # Hero Section additions
    @{ id = [Guid]::NewGuid().ToString(); alias = "demoIframeUrl"; name = "Demo iframe URL"; dataType = @{ id = $textstringId }; container = @{ id = $heroTabId }; sortOrder = 10 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "primaryCtaText"; name = "Primary CTA Text"; dataType = @{ id = $textstringId }; container = @{ id = $heroTabId }; sortOrder = 11 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "primaryCtaUrl"; name = "Primary CTA URL"; dataType = @{ id = $textstringId }; container = @{ id = $heroTabId }; sortOrder = 12 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "secondaryCtaText"; name = "Secondary CTA Text"; dataType = @{ id = $textstringId }; container = @{ id = $heroTabId }; sortOrder = 13 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "secondaryCtaUrl"; name = "Secondary CTA URL"; dataType = @{ id = $textstringId }; container = @{ id = $heroTabId }; sortOrder = 14 }
    
    # Header Section
    @{ id = [Guid]::NewGuid().ToString(); alias = "logoText"; name = "Logo Text"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 0 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink1Text"; name = "Nav Link 1 Text"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 1 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink1Url"; name = "Nav Link 1 URL"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 2 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink2Text"; name = "Nav Link 2 Text"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 3 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink2Url"; name = "Nav Link 2 URL"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 4 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink3Text"; name = "Nav Link 3 Text"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 5 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink3Url"; name = "Nav Link 3 URL"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 6 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink4Text"; name = "Nav Link 4 Text"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 7 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink4Url"; name = "Nav Link 4 URL"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 8 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "ctaButtonText"; name = "CTA Button Text"; dataType = @{ id = $textstringId }; container = @{ id = $headerTabId }; sortOrder = 9 }
    
    # Services Section
    @{ id = [Guid]::NewGuid().ToString(); alias = "servicesHeading"; name = "Services Heading"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 0 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "servicesSubheading"; name = "Services Subheading"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 1 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service1Title"; name = "Service 1 Title"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 2 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service1Icon"; name = "Service 1 Icon"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 3 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service1Description"; name = "Service 1 Description"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 4 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service2Title"; name = "Service 2 Title"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 5 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service2Icon"; name = "Service 2 Icon"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 6 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service2Description"; name = "Service 2 Description"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 7 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service3Title"; name = "Service 3 Title"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 8 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service3Icon"; name = "Service 3 Icon"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 9 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service3Description"; name = "Service 3 Description"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 10 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service4Title"; name = "Service 4 Title"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 11 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service4Icon"; name = "Service 4 Icon"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 12 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service4Description"; name = "Service 4 Description"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 13 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service5Title"; name = "Service 5 Title"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 14 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service5Icon"; name = "Service 5 Icon"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 15 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service5Description"; name = "Service 5 Description"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 16 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service6Title"; name = "Service 6 Title"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 17 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service6Icon"; name = "Service 6 Icon"; dataType = @{ id = $textstringId }; container = @{ id = $servicesTabId }; sortOrder = 18 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service6Description"; name = "Service 6 Description"; dataType = @{ id = $textareaId }; container = @{ id = $servicesTabId }; sortOrder = 19 }
    
    # Clients Section
    @{ id = [Guid]::NewGuid().ToString(); alias = "client1Name"; name = "Client 1 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 0 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client2Name"; name = "Client 2 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 1 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client3Name"; name = "Client 3 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 2 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client4Name"; name = "Client 4 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 3 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client5Name"; name = "Client 5 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 4 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client6Name"; name = "Client 6 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 5 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client7Name"; name = "Client 7 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 6 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client8Name"; name = "Client 8 Name"; dataType = @{ id = $textstringId }; container = @{ id = $clientsTabId }; sortOrder = 7 }
)

$updatePayload = @{
    allowedAsRoot = $docType.allowedAsRoot
    allowedDocumentTypes = $docType.allowedDocumentTypes
    cleanup = $docType.cleanup
    collection = $docType.collection
    compositions = $docType.compositions
    containers = $allContainers
    properties = $newProperties
} | ConvertTo-Json -Depth 10

Write-Host "Updating document type with 43 new properties..." -ForegroundColor Yellow
try {
    $updateResponse = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Headers $headers -Method Put -Body $updatePayload
    Write-Host "`nSUCCESS! Document type updated!" -ForegroundColor Green
    Write-Host "Added 3 new tabs: Header Section, Services Section, Clients Section" -ForegroundColor White
    Write-Host "Added 43 new properties total" -ForegroundColor White
    Write-Host "`nRefresh your backoffice to see the new fields!" -ForegroundColor Cyan
} catch {
    Write-Host "`nERROR: Failed to update document type" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host "Details: $($_.ErrorDetails.Message)" -ForegroundColor Yellow
    }
    exit 1
}
