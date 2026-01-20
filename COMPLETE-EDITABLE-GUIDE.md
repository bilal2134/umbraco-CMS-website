# Make Everything Editable from Backoffice - Complete Guide

## Overview
This guide will help you add ALL hardcoded content to the Umbraco backoffice for editing. Since the MCP `update-document-type` tool is disabled, you'll need to add these properties manually via the UI.

## Total Time: ~15-20 minutes

---

## Step 1: Add Service Card Properties (6 services × 3 fields = 18 properties)

### Login & Navigate:
1. Go to https://localhost:44357/umbraco
2. Settings → Document Types → **BPO Homepage Complete**

### Create "Services Section" Tab:
1. Click **Add tab** → Name: `Services Section` → Scroll down and click **Submit**

### Add Properties for Each Service Card:

#### Service 1:
- **Property Name:** Service 1 Title | **Alias:** `service1Title` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 1 Icon | **Alias:** `service1Icon` | **Data Type:** Textstring | **Tab:** Services Section  
  **Description:** Font Awesome class (e.g., fas fa-briefcase)
- **Property Name:** Service 1 Description | **Alias:** `service1Description` | **Data Type:** Textarea | **Tab:** Services Section

#### Service 2:
- **Property Name:** Service 2 Title | **Alias:** `service2Title` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 2 Icon | **Alias:** `service2Icon` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 2 Description | **Alias:** `service2Description` | **Data Type:** Textarea | **Tab:** Services Section

#### Service 3:
- **Property Name:** Service 3 Title | **Alias:** `service3Title` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 3 Icon | **Alias:** `service3Icon` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 3 Description | **Alias:** `service3Description` | **Data Type:** Textarea | **Tab:** Services Section

#### Service 4:
- **Property Name:** Service 4 Title | **Alias:** `service4Title` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 4 Icon | **Alias:** `service4Icon` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 4 Description | **Alias:** `service4Description` | **Data Type:** Textarea | **Tab:** Services Section

#### Service 5:
- **Property Name:** Service 5 Title | **Alias:** `service5Title` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 5 Icon | **Alias:** `service5Icon` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 5 Description | **Alias:** `service5Description` | **Data Type:** Textarea | **Tab:** Services Section

#### Service 6:
- **Property Name:** Service 6 Title | **Alias:** `service6Title` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 6 Icon | **Alias:** `service6Icon` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Service 6 Description | **Alias:** `service6Description` | **Data Type:** Textarea | **Tab:** Services Section

### Also Add:
- **Property Name:** Services Heading | **Alias:** `servicesHeading` | **Data Type:** Textstring | **Tab:** Services Section
- **Property Name:** Services Subheading | **Alias:** `servicesSubheading` | **Data Type:** Textarea | **Tab:** Services Section

**Total: 20 properties** for Services Section

Click **Save** (top right)

---

## Step 2: Add Client Logo Properties (8 clients)

### Create "Clients Section" Tab:
1. Click **Add tab** → Name: `Clients Section` → **Submit**

### Add Properties:
- **Property Name:** Client 1 Name | **Alias:** `client1Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 2 Name | **Alias:** `client2Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 3 Name | **Alias:** `client3Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 4 Name | **Alias:** `client4Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 5 Name | **Alias:** `client5Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 6 Name | **Alias:** `client6Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 7 Name | **Alias:** `client7Name` | **Data Type:** Textstring | **Tab:** Clients Section
- **Property Name:** Client 8 Name | **Alias:** `client8Name` | **Data Type:** Textstring | **Tab:** Clients Section

**Total: 8 properties** for Clients Section

Click **Save**

---

## Step 3: Add Header/Navigation Properties

### Create "Header Section" Tab:
1. Click **Add tab** → Name: `Header Section` → **Submit**

### Add Properties:
- **Property Name:** Logo Text | **Alias:** `logoText` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 1 Text | **Alias:** `navLink1Text` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 1 URL | **Alias:** `navLink1Url` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 2 Text | **Alias:** `navLink2Text` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 2 URL | **Alias:** `navLink2Url` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 3 Text | **Alias:** `navLink3Text` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 3 URL | **Alias:** `navLink3Url` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 4 Text | **Alias:** `navLink4Text` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** Nav Link 4 URL | **Alias:** `navLink4Url` | **Data Type:** Textstring | **Tab:** Header Section
- **Property Name:** CTA Button Text | **Alias:** `ctaButtonText` | **Data Type:** Textstring | **Tab:** Header Section

**Total: 10 properties** for Header Section

Click **Save**

---

## Step 4: Add iframe/Demo Properties

### Add to Hero Section Tab:
1. Go to **Hero Section** tab in the document type
2. Add these properties:

- **Property Name:** Demo iframe URL | **Alias:** `demoIframeUrl` | **Data Type:** Textstring | **Tab:** Hero Section  
  **Description:** Full URL for the iframe source
- **Property Name:** Primary CTA Text | **Alias:** `primaryCtaText` | **Data Type:** Textstring | **Tab:** Hero Section
- **Property Name:** Primary CTA URL | **Alias:** `primaryCtaUrl` | **Data Type:** Textstring | **Tab:** Hero Section
- **Property Name:** Secondary CTA Text | **Alias:** `secondaryCtaText` | **Data Type:** Textstring | **Tab:** Hero Section
- **Property Name:** Secondary CTA URL | **Alias:** `secondaryCtaUrl` | **Data Type:** Textstring | **Tab:** Hero Section

**Total: 5 properties** added to Hero Section

Click **Save**

---

## Summary of All New Properties

### Total Properties to Add: **43 new properties**

**By Tab:**
- **Hero Section:** +5 properties (iframe, CTA buttons)
- **Services Section:** 20 properties (6 cards + 2 headings)
- **Clients Section:** 8 properties (8 client names)
- **Header Section:** 10 properties (logo, nav links, CTA)

### Existing Properties (Already Added):
- Hero Section: heroTitle, heroSubtitle (2)
- About Section: aboutParagraph1-3, stats (7)
- Contact Section: contactEmail, contactPhone, contactAddress (3)

**Grand Total: 55 editable properties** 🎉

---

## Step 5: Fill Content in Backoffice

After adding all properties:

1. **Content** → **BPO Homepage**
2. Fill in all the fields with content from the current hardcoded version
3. **Save and Publish**

### Sample Content for Services:

**Service 1:**
- Title: Business Consulting
- Icon: fas fa-briefcase
- Description: Strategic guidance and expert consulting to optimize your business processes and drive sustainable growth.

**Service 2:**
- Title: Cloud Solutions
- Icon: fas fa-cloud
- Description: Scalable cloud infrastructure and migration services powered by Microsoft Azure and leading platforms.

**Service 3:**
- Title: Digital Transformation
- Icon: fas fa-rocket
- Description: End-to-end digital transformation services that modernize your operations and enhance customer experiences.

**Service 4:**
- Title: Data Analytics
- Icon: fas fa-chart-line
- Description: Advanced analytics and business intelligence solutions that turn data into actionable insights.

**Service 5:**
- Title: AI & Automation
- Icon: fas fa-robot
- Description: Intelligent automation and AI-powered solutions to streamline workflows and boost productivity.

**Service 6:**
- Title: Security & Compliance
- Icon: fas fa-shield-alt
- Description: Robust security frameworks and compliance solutions to protect your digital assets.

### Sample Content for Clients:
- Client 1: Microsoft
- Client 2: Amazon
- Client 3: Google
- Client 4: Apple
- Client 5: Meta
- Client 6: Oracle
- Client 7: IBM
- Client 8: SAP

### Sample Content for Header:
- Logo Text: Greybeard
- Nav Link 1: Home | #home
- Nav Link 2: Services | #services
- Nav Link 3: About | #about
- Nav Link 4: Contact | #contact
- CTA Button: Get Started

---

## Why So Many Properties?

Since the MCP `update-document-type` tool is disabled and Block List data types require manual creation in the UI, the fastest approach is to create individual properties for each repeatable item (service cards, client logos, etc.).

**Alternative:** If you want to use Block List (more flexible for adding/removing items), you would need to:
1. Create Element Types for each block
2. Create Block List Data Types
3. This adds complexity but provides more flexibility

The current approach (individual properties) is:
✅ Faster to implement
✅ Easier to fill in backoffice
✅ No Block List complexity
❌ Fixed number of items (6 services, 8 clients)

---

**Next Step:** Once you add these properties, I'll update the template to use them! Let me know when you're ready.
