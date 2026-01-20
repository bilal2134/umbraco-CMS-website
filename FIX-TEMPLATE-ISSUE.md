# Fix: Template Not Assigned to Document Type

## The Issue

The new document type I created has all 12 properties but doesn't have the template linked to it. The MCP `create-document-type` tool doesn't support adding templates (tool limitation mentioned in docs: "Do not try to add templates to document types they are not currently supported").

## Solution: Manually Link Template in Umbraco UI (2 minutes)

### Step 1: Login to Backoffice
1. Go to https://localhost:44357/umbraco
2. Login with your admin credentials

### Step 2: Find the Document Type
1. Click on **Settings** in the left sidebar
2. Click on **Document Types**
3. Find and click **BPO Homepage Complete**

### Step 3: Assign the Template
1. In the right panel, look for the **Templates** section
2. Click **+ Add template**
3. Select **BPOHomepage** from the dropdown
4. Set it as the **default template** (check the checkbox)
5. Click **Save** (top right)

### Step 4: Go Back to Content
1. Click on **Content** in the left sidebar
2. Click on **BPO Homepage**
3. In the right panel under **Info**, you should now see the template assigned
4. If not, click the **Template** dropdown and select **BPOHomepage**
5. Click **Save and Publish**

### Step 5: Refresh Website
1. Go to https://localhost:44357
2. You should see the beautiful homepage with all editable content!

## Alternative: Use Original Document Type

If you prefer, you can use the **PROPERTY-SETUP-GUIDE.md** to manually add the 12 properties to the original "BPO Homepage" document type (which already has the template linked). This would take about 5 minutes.

### Quick Steps for Original Approach:
1. Settings → Document Types → BPO Homepage
2. Add the 12 properties from PROPERTY-SETUP-GUIDE.md (copy/paste the details)
3. Save
4. Content → BPO Homepage → Fill in content → Save and Publish

## Why This Happened

The MCP tool `mcp_umbraco-mcp_create-document-type` has a documented limitation: "Do not try to add templates to document types they are not currently supported". I created the document type with all properties but couldn't link the template programmatically.

---

**Estimated Time:** 2 minutes to link template OR 5 minutes to add properties to original type

Choose whichever is easier for you!
