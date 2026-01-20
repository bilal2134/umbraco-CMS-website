# PowerShell Script to Add All Editable Properties via Umbraco API
# This script adds 43 new properties to make everything editable from backoffice

# Configuration
$baseUrl = "https://localhost:44357"
$clientId = "c51b93c4-8891-499b-9af1-9ecaab0b8303"
$clientSecret = "abcd123456"
$documentTypeId = "3c26f5ee-3eac-4c22-bbd4-7a37680ac91b"
$textstringDataTypeId = "0cc0eba1-9960-42c9-bf9b-60e150b429ae"
$textareaDataTypeId = "c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3"

Write-Host "🚀 Adding All Editable Properties to BPO Homepage Document Type" -ForegroundColor Cyan
Write-Host ""

# Skip SSL validation for localhost
if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type)
{
    $certCallback = @"
        using System;
        using System.Net;
        using System.Net.Security;
        using System.Security.Cryptography.X509Certificates;
        public class ServerCertificateValidationCallback
        {
            public static void Ignore()
            {
                if(ServicePointManager.ServerCertificateValidationCallback ==null)
                {
                    ServicePointManager.ServerCertificateValidationCallback += 
                        delegate
                        (
                            Object obj, 
                            X509Certificate certificate, 
                            X509Chain chain, 
                            SslPolicyErrors errors
                        )
                        {
                            return true;
                        };
                }
            }
        }
"@
    Add-Type $certCallback
}
[ServerCertificateValidationCallback]::Ignore()

# Get OAuth token
Write-Host "⏳ Getting OAuth token..." -ForegroundColor Yellow
$tokenBody = @{
    grant_type = "client_credentials"
    client_id = $clientId
    client_secret = $clientSecret
}
$tokenResponse = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/security/back-office/token" -Method Post -Body $tokenBody -ContentType "application/x-www-form-urlencoded"
$token = $tokenResponse.access_token
Write-Host "✅ Token obtained!" -ForegroundColor Green
Write-Host ""

# Get current document type
Write-Host "⏳ Fetching current document type..." -ForegroundColor Yellow
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}
$documentType = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Headers $headers -Method Get
Write-Host "✅ Current document type retrieved!" -ForegroundColor Green
Write-Host ""

# Create new containers (tabs)
$containers = @(
    $documentType.containers
    @{
        id = [Guid]::NewGuid().ToString()
        name = "Services Section"
        parent = $null
        sortOrder = 10
        type = "Tab"
    }
    @{
        id = [Guid]::NewGuid().ToString()
        name = "Clients Section"
        parent = $null
        sortOrder = 11
        type = "Tab"
    }
    @{
        id = [Guid]::NewGuid().ToString()
        name = "Header Section"
        parent = $null
        sortOrder = 12
        type = "Tab"
    }
)

$servicesTabId = $containers | Where-Object { $_.name -eq "Services Section" } | Select-Object -ExpandProperty id
$clientsTabId = $containers | Where-Object { $_.name -eq "Clients Section" } | Select-Object -ExpandProperty id
$headerTabId = $containers | Where-Object { $_.name -eq "Header Section" } | Select-Object -ExpandProperty id
$heroTabId = $containers | Where-Object { $_.name -eq "Hero Section" } | Select-Object -ExpandProperty id

# Create all new properties
$newProperties = @(
    $documentType.properties
    
    # Services Section (20 properties)
    @{ id = [Guid]::NewGuid().ToString(); alias = "servicesHeading"; name = "Services Heading"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 0 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "servicesSubheading"; name = "Services Subheading"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 1 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service1Title"; name = "Service 1 Title"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 2 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service1Icon"; name = "Service 1 Icon"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 3 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service1Description"; name = "Service 1 Description"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 4 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service2Title"; name = "Service 2 Title"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 5 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service2Icon"; name = "Service 2 Icon"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 6 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service2Description"; name = "Service 2 Description"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 7 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service3Title"; name = "Service 3 Title"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 8 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service3Icon"; name = "Service 3 Icon"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 9 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service3Description"; name = "Service 3 Description"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 10 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service4Title"; name = "Service 4 Title"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 11 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service4Icon"; name = "Service 4 Icon"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 12 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service4Description"; name = "Service 4 Description"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 13 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service5Title"; name = "Service 5 Title"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 14 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service5Icon"; name = "Service 5 Icon"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 15 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service5Description"; name = "Service 5 Description"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 16 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service6Title"; name = "Service 6 Title"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 17 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service6Icon"; name = "Service 6 Icon"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 18 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "service6Description"; name = "Service 6 Description"; dataType = @{ id = $textareaDataTypeId }; container = @{ id = $servicesTabId }; sortOrder = 19 }
    
    # Clients Section (8 properties)
    @{ id = [Guid]::NewGuid().ToString(); alias = "client1Name"; name = "Client 1 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 0 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client2Name"; name = "Client 2 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 1 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client3Name"; name = "Client 3 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 2 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client4Name"; name = "Client 4 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 3 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client5Name"; name = "Client 5 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 4 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client6Name"; name = "Client 6 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 5 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client7Name"; name = "Client 7 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 6 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "client8Name"; name = "Client 8 Name"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $clientsTabId }; sortOrder = 7 }
    
    # Header Section (10 properties)
    @{ id = [Guid]::NewGuid().ToString(); alias = "logoText"; name = "Logo Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 0 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink1Text"; name = "Nav Link 1 Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 1 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink1Url"; name = "Nav Link 1 URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 2 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink2Text"; name = "Nav Link 2 Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 3 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink2Url"; name = "Nav Link 2 URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 4 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink3Text"; name = "Nav Link 3 Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 5 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink3Url"; name = "Nav Link 3 URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 6 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink4Text"; name = "Nav Link 4 Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 7 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "navLink4Url"; name = "Nav Link 4 URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 8 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "ctaButtonText"; name = "CTA Button Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $headerTabId }; sortOrder = 9 }
    
    # Hero Section additions (5 properties)
    @{ id = [Guid]::NewGuid().ToString(); alias = "demoIframeUrl"; name = "Demo iframe URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $heroTabId }; sortOrder = 10 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "primaryCtaText"; name = "Primary CTA Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $heroTabId }; sortOrder = 11 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "primaryCtaUrl"; name = "Primary CTA URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $heroTabId }; sortOrder = 12 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "secondaryCtaText"; name = "Secondary CTA Text"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $heroTabId }; sortOrder = 13 }
    @{ id = [Guid]::NewGuid().ToString(); alias = "secondaryCtaUrl"; name = "Secondary CTA URL"; dataType = @{ id = $textstringDataTypeId }; container = @{ id = $heroTabId }; sortOrder = 14 }
)

# Prepare update payload
$updatePayload = @{
    allowedAsRoot = $documentType.allowedAsRoot
    allowedDocumentTypes = $documentType.allowedDocumentTypes
    cleanup = $documentType.cleanup
    collection = $documentType.collection
    compositions = $documentType.compositions
    containers = $containers
    properties = $newProperties
} | ConvertTo-Json -Depth 10

# Update document type
Write-Host "⏳ Updating document type with 43 new properties..." -ForegroundColor Yellow
try {
    $updateResponse = Invoke-RestMethod -Uri "$baseUrl/umbraco/management/api/v1/document-type/$documentTypeId" -Headers $headers -Method Put -Body $updatePayload
    Write-Host "✅ SUCCESS! Document type updated with all editable properties!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 Summary:" -ForegroundColor Cyan
    Write-Host "  • Services Section: 20 properties (6 cards + 2 headings)" -ForegroundColor White
    Write-Host "  • Clients Section: 8 properties" -ForegroundColor White
    Write-Host "  • Header Section: 10 properties" -ForegroundColor White
    Write-Host "  • Hero Section: +5 properties (iframe, CTAs)" -ForegroundColor White
    Write-Host "  • Total New Properties: 43" -ForegroundColor Green
    Write-Host ""
    Write-Host "🎉 Next Step: Go to backoffice and fill in the content!" -ForegroundColor Cyan
} catch {
    Write-Host "❌ ERROR: Failed to update document type" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "📝 Response:" -ForegroundColor Yellow
    Write-Host $_.ErrorDetails.Message -ForegroundColor White
}
