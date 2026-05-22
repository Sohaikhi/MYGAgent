$baseUrl = "https://culturatech.testrail.io/index.php?/api/v2"
$sectionId = 21786  # AI TestCreation section
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:TESTRAIL_USER):$($env:TESTRAIL_PASS)"))
$headers = @{ "Authorization" = "Basic $auth"; "Content-Type" = "application/json" }

$testCases = @(
    # ============================================================
    # SECTION 1: START A QUOTE - HAPPY PATH
    # ============================================================
    @{
        title = "TC-01: Navigate to Quotes Screen"
        custom_preconds = "User is logged in as a Grower with a valid store account"
        custom_steps_separated = @(
            @{ content = "Navigate to the Quotes section from the main menu"; expected = "Quotes screen loads successfully with two sections visible: Start a Quote and Quote History" }
            @{ content = "Verify the layout and structure of the page"; expected = "Both sections are displayed correctly. UI matches the expected design" }
        )
    },
    @{
        title = "TC-02: Verify Start a Quote - UI Elements Present"
        custom_preconds = "User is on the Quotes screen"
        custom_steps_separated = @(
            @{ content = "Observe the Start a Quote section"; expected = "Section header Start a Quote is displayed" }
            @{ content = "Verify Account ID dropdown is present"; expected = "Account ID dropdown is visible and populated with name IDs bound to the grower account" }
            @{ content = "Verify Products Category search field is present"; expected = "Product search field is visible with appropriate placeholder text" }
            @{ content = "Verify Add Another Product button is present"; expected = "Button is visible and enabled" }
            @{ content = "Verify Message field is present"; expected = "Message text field is visible and marked as optional" }
            @{ content = "Verify Cancel and Get a Quote buttons are present"; expected = "Both buttons are visible. Cancel is enabled. Get a Quote is enabled or disabled based on form state" }
        )
    },
    @{
        title = "TC-03: Select Account ID from Dropdown"
        custom_preconds = "User is on the Start a Quote section. Grower account has multiple name IDs"
        custom_steps_separated = @(
            @{ content = "Click the Account ID dropdown"; expected = "Dropdown opens showing all name IDs bound to the grower store account" }
            @{ content = "Select a specific name ID"; expected = "The selected name ID is displayed in the dropdown field. The selection persists" }
        )
    },
    @{
        title = "TC-04: Search Product by Name"
        custom_preconds = "User is on the Start a Quote section with Account ID selected"
        custom_steps_separated = @(
            @{ content = "Click the Products Category search field"; expected = "Search field is active and ready for input" }
            @{ content = "Type a valid product name"; expected = "Search results appear showing matching products with their descriptions" }
            @{ content = "Select a product from the results"; expected = "Product is added to the quote with its description displayed. Quantity field appears with the correct unit of measure for that product" }
        )
    },
    @{
        title = "TC-05: Search Product by Description"
        custom_preconds = "User is on the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Type a product description in the Products Category search field"; expected = "Search results appear showing products matching the description" }
            @{ content = "Select a product from the results"; expected = "Product is added with correct details and appropriate unit of measure" }
        )
    },
    @{
        title = "TC-06: Search Product by Item Number"
        custom_preconds = "User is on the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Type a valid item number in the Products Category search field"; expected = "Search results display the specific product matching that item number" }
            @{ content = "Select the product"; expected = "Product is added to the quote with correct description and unit of measure" }
        )
    },
    @{
        title = "TC-07: Verify Unique Unit of Measure per Product"
        custom_preconds = "User is on the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Search and select a grain-type product"; expected = "Quantity unit of measure displays as Bushels" }
            @{ content = "Add another product that is liquid such as water"; expected = "Quantity unit of measure displays as Liter or Gallon" }
            @{ content = "Verify each product row shows its own unique unit"; expected = "Each product line item has its own correct unit of measure independent of others" }
        )
    },
    @{
        title = "TC-08: Add Multiple Products Using Add Another Product Button"
        custom_preconds = "User has already selected one product in the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Click Add Another Product button"; expected = "A new product search row is added below the existing product" }
            @{ content = "Search and select a second product"; expected = "Second product is added with its own quantity and unit of measure" }
            @{ content = "Click Add Another Product again and add a third product"; expected = "Third product row is added. All three products are displayed with correct details" }
        )
    },
    @{
        title = "TC-09: Enter Quantity for a Product"
        custom_preconds = "User has selected a product in the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Locate the quantity field for the selected product"; expected = "Quantity field is visible next to the product with the correct unit of measure label" }
            @{ content = "Enter a valid numeric quantity such as 100"; expected = "Quantity is accepted and displayed correctly" }
        )
    },
    @{
        title = "TC-10: Add Optional Message to Quote Request"
        custom_preconds = "User has selected product(s) and entered quantities"
        custom_steps_separated = @(
            @{ content = "Click the Message text field"; expected = "Message field is active and ready for input" }
            @{ content = "Type a note or comment such as Need delivery by next Friday"; expected = "Text is accepted and displayed in the message field" }
        )
    },
    @{
        title = "TC-11: Submit Quote Request - Happy Path (Get a Quote)"
        custom_preconds = "User has filled Account ID and selected product(s) with quantities"
        custom_steps_separated = @(
            @{ content = "Click the Get a Quote button"; expected = "Quote request is submitted successfully. A success confirmation message is displayed" }
            @{ content = "Navigate to Quote History section"; expected = "The newly created quote appears at the top of the grid with status Requested and current date" }
        )
    },
    @{
        title = "TC-12: Cancel Quote Creation"
        custom_preconds = "User has partially filled the Start a Quote form (Account ID selected and products added)"
        custom_steps_separated = @(
            @{ content = "Click the Cancel button"; expected = "The form is cleared or reset. No quote request is submitted. No entry appears in Quote History" }
            @{ content = "Verify no API call was made to create a quote"; expected = "No new quote record exists in the backend" }
        )
    },

    # ============================================================
    # SECTION 2: START A QUOTE - VALIDATION AND NEGATIVE
    # ============================================================
    @{
        title = "TC-13: Submit Quote Without Selecting Account ID"
        custom_preconds = "User is on the Start a Quote section. Account ID is not selected"
        custom_steps_separated = @(
            @{ content = "Leave Account ID dropdown unselected"; expected = "No account is selected" }
            @{ content = "Select a product and enter quantity"; expected = "Product and quantity are accepted" }
            @{ content = "Click Get a Quote"; expected = "Submission is blocked. Validation error is displayed indicating Account ID is required" }
        )
    },
    @{
        title = "TC-14: Submit Quote Without Selecting Any Product"
        custom_preconds = "User is on the Start a Quote section with Account ID selected"
        custom_steps_separated = @(
            @{ content = "Do not search or select any product"; expected = "No product is in the quote" }
            @{ content = "Click Get a Quote"; expected = "Submission is blocked. Validation error indicates at least one product is required" }
        )
    },
    @{
        title = "TC-15: Submit Quote With Product Selected But No Quantity"
        custom_preconds = "User has selected a product but left the quantity field empty or zero"
        custom_steps_separated = @(
            @{ content = "Select a valid product from search"; expected = "Product is added to the quote" }
            @{ content = "Leave quantity field empty or enter 0"; expected = "Quantity shows empty or zero" }
            @{ content = "Click Get a Quote"; expected = "Submission is blocked. Validation error indicates quantity is required and must be greater than zero" }
        )
    },
    @{
        title = "TC-16: Enter Negative Quantity"
        custom_preconds = "User has selected a product"
        custom_steps_separated = @(
            @{ content = "Enter a negative number such as -5 in the quantity field"; expected = "Input is either rejected or validation error is displayed. Negative quantities are not allowed" }
        )
    },
    @{
        title = "TC-17: Enter Non-Numeric Characters in Quantity Field"
        custom_preconds = "User has selected a product"
        custom_steps_separated = @(
            @{ content = "Enter alphabetic characters such as abc in the quantity field"; expected = "Field rejects non-numeric input or shows a validation error" }
            @{ content = "Enter special characters in the quantity field"; expected = "Field rejects special characters or shows a validation error" }
        )
    },
    @{
        title = "TC-18: Enter Extremely Large Quantity"
        custom_preconds = "User has selected a product"
        custom_steps_separated = @(
            @{ content = "Enter an extremely large number such as 99999999999 in the quantity field"; expected = "Field either limits input length or shows validation for maximum allowed quantity" }
        )
    },
    @{
        title = "TC-19: Enter Decimal Quantity"
        custom_preconds = "User has selected a product"
        custom_steps_separated = @(
            @{ content = "Enter a decimal value such as 10.5 in the quantity field"; expected = "Decimal is either accepted if business allows partial units or rejected with appropriate validation message" }
        )
    },
    @{
        title = "TC-20: Search Product With No Matching Results"
        custom_preconds = "User is on the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Type a random invalid string in the product search field such as xyznonexistent123"; expected = "No results are displayed. A No products found message or empty state is shown" }
        )
    },
    @{
        title = "TC-21: Select the Same Product Twice"
        custom_preconds = "User has already added Product A to the quote"
        custom_steps_separated = @(
            @{ content = "Click Add Another Product"; expected = "New product row is added" }
            @{ content = "Search and select the same Product A again"; expected = "System either prevents duplicate selection with a message OR allows it depending on business rule. Verify expected behavior" }
        )
    },
    @{
        title = "TC-22: Submit Quote Without Message (Optional Field)"
        custom_preconds = "User has filled Account ID and selected product(s) with valid quantities. Message field is left empty"
        custom_steps_separated = @(
            @{ content = "Leave the Message field empty"; expected = "Field remains empty. No validation error since it is optional" }
            @{ content = "Click Get a Quote"; expected = "Quote request is submitted successfully without a message. Quote appears in history" }
        )
    },
    @{
        title = "TC-23: Message Field - Maximum Character Limit"
        custom_preconds = "User is on the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Enter an extremely long text in the Message field with 5000+ characters"; expected = "Field either enforces a character limit and stops accepting input or truncates. If no limit then text is accepted and saved completely" }
        )
    },
    @{
        title = "TC-24: Message Field - Special Characters and Script Injection"
        custom_preconds = "User is on the Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Enter HTML script tags in Message field"; expected = "Input is sanitized. No script execution occurs. Characters are stored as plain text" }
            @{ content = "Enter SQL injection patterns in the Message field"; expected = "Input is treated as plain text. No backend SQL execution occurs" }
        )
    },

    # ============================================================
    # SECTION 3: QUOTE HISTORY - DISPLAY AND FILTERS
    # ============================================================
    @{
        title = "TC-25: Verify Quote History Grid Loads on Page Load"
        custom_preconds = "User is on the Quotes screen. Previous quote requests exist"
        custom_steps_separated = @(
            @{ content = "Observe the Quote History section"; expected = "Data grid loads with all historical quotes. Loading indicator is shown while data fetches" }
            @{ content = "Verify grid columns are present"; expected = "Grid displays: Quote Number, Quote Date, Account ID, Item, Status, and associated dates" }
        )
    },
    @{
        title = "TC-26: Verify Most Recent Quote Appears at Top"
        custom_preconds = "User has just submitted a new quote request"
        custom_steps_separated = @(
            @{ content = "Navigate to Quote History section"; expected = "The newly created quote appears at the very top of the grid" }
            @{ content = "Verify its status"; expected = "Status shows Requested with the current date displayed below it" }
        )
    },
    @{
        title = "TC-27: Verify Quote Status Lifecycle - Requested to Ordered"
        custom_preconds = "A quote exists with status Requested. The recipient has confirmed or accepted the quote"
        custom_steps_separated = @(
            @{ content = "Refresh the Quote History grid after the quote is confirmed"; expected = "Quote status changes from Requested to Ordered" }
            @{ content = "Verify the ordered date is displayed"; expected = "The ordered date appears below the Ordered status" }
        )
    },
    @{
        title = "TC-28: Verify Quote Status Lifecycle - Ordered to Expired"
        custom_preconds = "A quote exists with status Ordered and its order date has passed or expired"
        custom_steps_separated = @(
            @{ content = "View the Quote History after the order date has expired"; expected = "Quote status changes from Ordered to Expired" }
            @{ content = "Verify the expiration date is displayed"; expected = "The expiration date appears below the Expired status" }
        )
    },
    @{
        title = "TC-29: Verify Status Dates Display Below Each Status"
        custom_preconds = "Quotes exist in all three statuses: Requested, Ordered, Expired"
        custom_steps_separated = @(
            @{ content = "Observe a quote with status Requested"; expected = "Requested date is displayed directly below the status" }
            @{ content = "Observe a quote with status Ordered"; expected = "Ordered date is displayed directly below the status" }
            @{ content = "Observe a quote with status Expired"; expected = "Expired date is displayed directly below the status" }
        )
    },
    @{
        title = "TC-30: Filter by Quote Number"
        custom_preconds = "User is on Quote History section with multiple quotes visible"
        custom_steps_separated = @(
            @{ content = "Enter a specific quote number in the Quote Number filter"; expected = "Grid filters to show only the quote matching that number" }
            @{ content = "Enter a partial quote number"; expected = "Grid shows all quotes matching the partial number if partial search is supported" }
        )
    },
    @{
        title = "TC-31: Filter by Quote Date"
        custom_preconds = "User is on Quote History section with quotes from different dates"
        custom_steps_separated = @(
            @{ content = "Select a specific date in the Quote Date filter"; expected = "Grid filters to show only quotes created on that date" }
            @{ content = "Select a date range if supported"; expected = "Grid shows quotes within the selected date range" }
        )
    },
    @{
        title = "TC-32: Filter by Account ID"
        custom_preconds = "User is on Quote History section. Grower has multiple name IDs"
        custom_steps_separated = @(
            @{ content = "Select a specific Account ID from the filter dropdown"; expected = "Grid filters to show only quotes associated with the selected Account ID" }
        )
    },
    @{
        title = "TC-33: Filter by Item"
        custom_preconds = "User is on Quote History section with quotes containing different items"
        custom_steps_separated = @(
            @{ content = "Enter a product or item name in the Item filter"; expected = "Grid filters to show only quotes containing that item" }
        )
    },
    @{
        title = "TC-34: Clear Filter - Resets All Except Account ID"
        custom_preconds = "User has applied multiple filters (Quote Number, Date, Account ID, Item)"
        custom_steps_separated = @(
            @{ content = "Click the Clear Filter button"; expected = "All filter fields are cleared" }
            @{ content = "Verify Account ID filter after clearing"; expected = "Account ID automatically selects All showing all name IDs for the store account. It does NOT remain empty" }
            @{ content = "Verify the grid data"; expected = "Grid reloads showing all quotes for all Account IDs" }
        )
    },
    @{
        title = "TC-35: Filter Returns No Results"
        custom_preconds = "User is on Quote History section"
        custom_steps_separated = @(
            @{ content = "Enter a non-existent quote number in the filter"; expected = "Grid shows empty state with appropriate message such as No quotes found" }
            @{ content = "Verify grid behavior"; expected = "No data rows displayed. Export buttons may be disabled or export empty file" }
        )
    },
    @{
        title = "TC-36: Export to PDF"
        custom_preconds = "User is on Quote History with data visible in the grid"
        custom_steps_separated = @(
            @{ content = "Click Export to PDF button"; expected = "PDF file is generated and downloaded" }
            @{ content = "Open the downloaded PDF"; expected = "PDF contains the grid data matching what is displayed on screen. Formatting is correct and readable" }
        )
    },
    @{
        title = "TC-37: Export to Excel"
        custom_preconds = "User is on Quote History with data visible in the grid"
        custom_steps_separated = @(
            @{ content = "Click Export to Excel button"; expected = "Excel file is generated and downloaded" }
            @{ content = "Open the downloaded Excel file"; expected = "Excel contains the grid data matching what is displayed on screen. All columns and data are correctly formatted" }
        )
    },
    @{
        title = "TC-38: Export with Filters Applied"
        custom_preconds = "User has applied filters and a subset of data is displayed in the grid"
        custom_steps_separated = @(
            @{ content = "Click Export to PDF with filters active"; expected = "PDF contains ONLY the filtered data not all quotes" }
            @{ content = "Click Export to Excel with filters active"; expected = "Excel contains ONLY the filtered data not all quotes" }
        )
    },
    @{
        title = "TC-39: Export with Empty Grid (No Data)"
        custom_preconds = "Grid shows no data either because no quotes exist or filters return no results"
        custom_steps_separated = @(
            @{ content = "Click Export to PDF"; expected = "Either export is disabled or hidden or an empty header-only PDF is generated with appropriate messaging" }
            @{ content = "Click Export to Excel"; expected = "Either export is disabled or hidden or an empty header-only Excel file is generated" }
        )
    },

    # ============================================================
    # SECTION 4: EDGE CASES
    # ============================================================
    @{
        title = "TC-40: Grower Account with Single Name ID - Account ID Behavior"
        custom_preconds = "Grower account has only ONE name ID bound to it"
        custom_steps_separated = @(
            @{ content = "Navigate to Start a Quote section"; expected = "Account ID dropdown either auto-selects the single name ID or shows only one option" }
            @{ content = "Navigate to Quote History filters"; expected = "Account ID filter either auto-selects the single ID or shows it as the only option" }
        )
    },
    @{
        title = "TC-41: Grower Account with Many Name IDs (10+)"
        custom_preconds = "Grower account has 10+ name IDs bound to it"
        custom_steps_separated = @(
            @{ content = "Open the Account ID dropdown in Start a Quote"; expected = "All name IDs are listed. Dropdown is scrollable if needed. Performance is acceptable" }
            @{ content = "Open the Account ID filter in Quote History"; expected = "All name IDs are listed along with All option" }
        )
    },
    @{
        title = "TC-42: Quote with Single Product vs Multiple Products Display"
        custom_preconds = "Quotes exist with both single and multiple products"
        custom_steps_separated = @(
            @{ content = "View a quote in history that has a single product"; expected = "Item column shows the single product correctly" }
            @{ content = "View a quote in history that has multiple products"; expected = "All products are displayed either in the same cell or expandable. No product data is lost" }
        )
    },
    @{
        title = "TC-43: Product Search - Minimum Character Trigger"
        custom_preconds = "User is in the Products Category search field"
        custom_steps_separated = @(
            @{ content = "Type a single character"; expected = "Verify if search triggers on 1 character or requires minimum such as 3 characters" }
            @{ content = "Type the minimum required characters"; expected = "Search results appear after minimum character threshold is met" }
        )
    },
    @{
        title = "TC-44: Remove a Product from Quote Before Submission"
        custom_preconds = "User has added multiple products to the quote"
        custom_steps_separated = @(
            @{ content = "Locate a remove or delete option on one of the product rows"; expected = "Remove or delete action is available per product row" }
            @{ content = "Remove one product"; expected = "Product is removed from the quote. Remaining products stay intact. Quote can still be submitted with remaining products" }
        )
    },
    @{
        title = "TC-45: Quote History - Pagination or Scroll Behavior with Large Data"
        custom_preconds = "Grower has 100+ historical quotes"
        custom_steps_separated = @(
            @{ content = "Navigate to Quote History"; expected = "Grid loads with pagination or infinite scroll. Not all 100+ records load at once for performance" }
            @{ content = "Navigate to next page or scroll down"; expected = "Additional records load correctly. Sorting order is maintained" }
        )
    },

    # ============================================================
    # SECTION 5: UI VALIDATION
    # ============================================================
    @{
        title = "TC-46: UI - Start a Quote Section Layout and Alignment"
        custom_preconds = "User is on the Quotes screen"
        custom_steps_separated = @(
            @{ content = "Observe the Start a Quote section header"; expected = "Header text is properly styled, aligned, and visible" }
            @{ content = "Verify spacing between form fields (Account ID, Products, Quantity, Message)"; expected = "Consistent spacing between fields. No overlapping elements" }
            @{ content = "Verify alignment of labels and input fields"; expected = "Labels are left-aligned or per design. Input fields are uniformly sized and aligned" }
            @{ content = "Verify Cancel and Get a Quote buttons placement"; expected = "Buttons are properly aligned. Proper spacing between them" }
        )
    },
    @{
        title = "TC-47: UI - Account ID Dropdown Visual Behavior"
        custom_preconds = "User is on Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Click the Account ID dropdown"; expected = "Dropdown opens with smooth animation. Options are readable and properly spaced" }
            @{ content = "Hover over dropdown options"; expected = "Hover state is visually indicated with highlight or color change" }
            @{ content = "Select an option and close dropdown"; expected = "Selected value is displayed in the field. Dropdown closes cleanly" }
        )
    },
    @{
        title = "TC-48: UI - Product Search Field Placeholder and Focus State"
        custom_preconds = "User is on Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Observe the Product search field before interaction"; expected = "Placeholder text is visible such as Search by name, description, or item number" }
            @{ content = "Click or focus the search field"; expected = "Field shows active or focus state with border color change or highlight" }
            @{ content = "Type a search term and observe results dropdown"; expected = "Results appear in a dropdown below the field. Dropdown does not overflow or cover critical UI elements" }
        )
    },
    @{
        title = "TC-49: UI - Product Row Display After Selection"
        custom_preconds = "User has selected a product from search results"
        custom_steps_separated = @(
            @{ content = "Observe the selected product row"; expected = "Product name and description is clearly displayed. Quantity field is visible with unit of measure label next to it" }
            @{ content = "Verify the unit of measure label"; expected = "Unit label such as Bushels or Liters is displayed adjacent to the quantity field and is not editable" }
            @{ content = "Verify visual separation between multiple product rows"; expected = "Each product row is visually distinct with border, spacing, or alternating background" }
        )
    },
    @{
        title = "TC-50: UI - Add Another Product Button State"
        custom_preconds = "User is on Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Observe the Add Another Product button before any product is added"; expected = "Button is visible and enabled" }
            @{ content = "Add a product and observe button position"; expected = "Button remains accessible below the last product row. Does not shift unexpectedly" }
            @{ content = "Hover over the button"; expected = "Hover state is visually indicated" }
        )
    },
    @{
        title = "TC-51: UI - Message Field Appearance and Behavior"
        custom_preconds = "User is on Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Observe the Message field"; expected = "Field is clearly labeled as optional. Adequate height for multi-line text" }
            @{ content = "Type a long message that exceeds one line"; expected = "Field expands or allows scrolling within the field. Text wraps properly" }
            @{ content = "Verify character count indicator if present"; expected = "Character count or remaining characters shown if applicable per design" }
        )
    },
    @{
        title = "TC-52: UI - Cancel Button Visual Feedback"
        custom_preconds = "User is on Start a Quote section with data entered"
        custom_steps_separated = @(
            @{ content = "Hover over Cancel button"; expected = "Hover state is visually indicated with color change or underline" }
            @{ content = "Click Cancel button"; expected = "Button shows click or active state. Action triggers immediately without delay" }
        )
    },
    @{
        title = "TC-53: UI - Get a Quote Button Visual States"
        custom_preconds = "User is on Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Observe Get a Quote button when form is incomplete with missing required fields"; expected = "Button is either disabled and greyed out or enabled but validates on click" }
            @{ content = "Fill all required fields and observe button"; expected = "Button is fully enabled with primary action styling such as solid color and prominent appearance" }
            @{ content = "Click the button"; expected = "Loading indicator appears on or near the button. Button is disabled during submission to prevent double-click" }
        )
    },
    @{
        title = "TC-54: UI - Validation Error Messages Display"
        custom_preconds = "User attempts to submit the quote with missing required fields"
        custom_steps_separated = @(
            @{ content = "Click Get a Quote with Account ID not selected"; expected = "Inline error message appears near the Account ID field. Error text is red or styled per design system" }
            @{ content = "Click Get a Quote with no product selected"; expected = "Error message indicates product selection is required. Message appears in correct location" }
            @{ content = "Click Get a Quote with product selected but no quantity"; expected = "Error appears next to the specific quantity field that is empty" }
            @{ content = "Fix one error and re-submit"; expected = "Fixed field error disappears. Remaining errors stay visible" }
        )
    },
    @{
        title = "TC-55: UI - Quote History Grid Layout and Columns"
        custom_preconds = "User is on Quote History section with data"
        custom_steps_separated = @(
            @{ content = "Verify grid column headers"; expected = "All expected columns are displayed: Quote Number, Quote Date, Account ID, Item, Status. Headers are properly aligned" }
            @{ content = "Verify row height and text truncation"; expected = "Row height is consistent. Long text is truncated with ellipsis or wrapped properly" }
            @{ content = "Verify alternating row colors if applicable"; expected = "Rows have alternating background for readability or consistent styling per design" }
        )
    },
    @{
        title = "TC-56: UI - Status Column Visual Indicators"
        custom_preconds = "Quote History contains quotes in all statuses (Requested, Ordered, Expired)"
        custom_steps_separated = @(
            @{ content = "Observe Requested status display"; expected = "Status text is visible with associated color or badge such as blue or neutral" }
            @{ content = "Observe Ordered status display"; expected = "Status text is visible with associated color or badge such as green or success" }
            @{ content = "Observe Expired status display"; expected = "Status text is visible with associated color or badge such as red or grey" }
            @{ content = "Verify dates below each status"; expected = "Dates are displayed in smaller or secondary text directly below the status. Proper date format is used" }
        )
    },
    @{
        title = "TC-57: UI - Filter Section Layout"
        custom_preconds = "User is on Quote History section"
        custom_steps_separated = @(
            @{ content = "Verify filter fields are displayed in a row or group above the grid"; expected = "Quote Number, Quote Date, Account ID, and Item filters are visible and properly aligned" }
            @{ content = "Verify Clear Filter button position"; expected = "Clear Filter button is positioned logically at end of filter row or below filters" }
            @{ content = "Verify filter field labels"; expected = "Each filter has a clear label or placeholder text indicating its purpose" }
        )
    },
    @{
        title = "TC-58: UI - Export Buttons Placement and Styling"
        custom_preconds = "User is on Quote History section"
        custom_steps_separated = @(
            @{ content = "Verify Export to PDF button location"; expected = "Button is positioned above or near the grid per design. Clearly identifiable with icon or text" }
            @{ content = "Verify Export to Excel button location"; expected = "Button is next to Export to PDF. Consistent styling with PDF button" }
            @{ content = "Hover over export buttons"; expected = "Hover states are visually indicated" }
        )
    },
    @{
        title = "TC-59: UI - Empty State Display (No Quote History)"
        custom_preconds = "Grower has no previous quote requests"
        custom_steps_separated = @(
            @{ content = "Navigate to Quote History section"; expected = "An appropriate empty state is shown such as No quotes found or illustration with message" }
            @{ content = "Verify filters and export buttons in empty state"; expected = "Filters may be hidden or disabled. Export buttons are disabled or hidden when no data exists" }
        )
    },
    @{
        title = "TC-60: UI - Loading States"
        custom_preconds = "User navigates to Quotes screen or performs an action"
        custom_steps_separated = @(
            @{ content = "Observe page during initial load"; expected = "Loading spinner or skeleton screen is displayed while data fetches" }
            @{ content = "Apply a filter and observe grid"; expected = "Grid shows loading indicator while filtering data" }
            @{ content = "Submit a quote and observe"; expected = "Submit button shows loading state. Form is not interactable during submission" }
            @{ content = "Trigger product search"; expected = "Search field shows loading indicator while fetching results" }
        )
    },
    @{
        title = "TC-61: UI - Success and Error Notification Messages"
        custom_preconds = "User performs various actions on the Quotes screen"
        custom_steps_separated = @(
            @{ content = "Submit a quote successfully"; expected = "Success message or toast appears such as Quote request submitted successfully. Message auto-dismisses or has close button" }
            @{ content = "Trigger an error such as network failure during submit"; expected = "Error message or toast appears with appropriate text. Styled in red or error color. Does not block entire UI" }
        )
    },
    @{
        title = "TC-62: UI - Responsive Behavior (Tablet or Smaller Screen)"
        custom_preconds = "User accesses the Quotes screen on a tablet or resized browser"
        custom_steps_separated = @(
            @{ content = "Resize browser to tablet width around 768px"; expected = "Layout adjusts. Form fields stack or resize appropriately. No horizontal overflow" }
            @{ content = "Verify Quote History grid at tablet width"; expected = "Grid columns adjust with horizontal scroll, column hiding, or responsive layout. Data remains readable" }
            @{ content = "Verify buttons remain accessible"; expected = "Cancel, Get a Quote, Export, and filter buttons are still clickable and not cut off" }
        )
    },
    @{
        title = "TC-63: UI - Keyboard Navigation (Accessibility)"
        custom_preconds = "User is on the Quotes screen using only keyboard"
        custom_steps_separated = @(
            @{ content = "Press Tab to navigate through form fields"; expected = "Focus moves in logical order: Account ID then Product search then Quantity then Message then Cancel then Get a Quote" }
            @{ content = "Open Account ID dropdown with keyboard using Enter or Space"; expected = "Dropdown opens. Arrow keys navigate options. Enter selects" }
            @{ content = "Navigate through Quote History filters with Tab"; expected = "Focus moves through each filter field in order. Clear Filter is reachable via Tab" }
        )
    },
    @{
        title = "TC-64: UI - Tooltip or Help Text Visibility"
        custom_preconds = "User is on Start a Quote section"
        custom_steps_separated = @(
            @{ content = "Hover over field labels or info icons if present"; expected = "Tooltip or help text appears explaining the field purpose" }
            @{ content = "Verify optional indicator on Message field"; expected = "Message field clearly indicates it is optional via label text, italic style, or lighter color" }
        )
    }
)

$successCount = 0
$failCount = 0

foreach ($tc in $testCases) {
    $body = @{
        title = $tc.title
        custom_preconds = $tc.custom_preconds
        custom_steps_separated = $tc.custom_steps_separated
    } | ConvertTo-Json -Depth 5

    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/add_case/$sectionId" -Method POST -Headers $headers -Body $body
        Write-Host "CREATED: $($response.title) (ID: $($response.id))" -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "FAILED: $($tc.title) - $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
    Start-Sleep -Milliseconds 500
}

Write-Host "`n===== SUMMARY =====" -ForegroundColor Cyan
Write-Host "Created: $successCount | Failed: $failCount" -ForegroundColor Cyan
