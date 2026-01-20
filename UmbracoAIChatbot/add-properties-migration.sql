-- SQL Migration to add properties to BPO Homepage Document Type
-- Run this in your SQLite database or use Umbraco's migration feature

-- Note: This is a reference for the structure needed
-- The easiest way is still to add via Umbraco UI or wait for MCP update tool

-- Properties to add:
-- Tab: Hero Section
--   1. heroTitle (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)
--   2. heroSubtitle (Textarea - c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3)

-- Tab: About Section  
--   3. aboutParagraph1 (Textarea - c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3)
--   4. aboutParagraph2 (Textarea - c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3)
--   5. aboutParagraph3 (Textarea - c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3)
--   6. statsProjects (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)
--   7. statsClients (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)
--   8. statsYears (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)
--   9. statsSatisfaction (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)

-- Tab: Contact Section
--   10. contactEmail (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)
--   11. contactPhone (Textstring - 0cc0eba1-9960-42c9-bf9b-60e150b429ae)
--   12. contactAddress (Textarea - c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3)
