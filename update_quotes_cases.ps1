$baseUrl = "https://culturatech.testrail.io/index.php?/api/v2"
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:TESTRAIL_USER):$($env:TESTRAIL_PASS)"))
$headers = @{ "Authorization" = "Basic $auth"; "Content-Type" = "application/json" }

$testCases = @(
    @{
        id = 182983
        custom_preconds = "<p>User is logged in as a Grower with a valid store account</p>"
        custom_steps = "<p>Navigate to the Quotes section from the main menu<br />Verify the layout and structure of the page</p>"
        custom_expected = "<p>Quotes screen loads successfully with two sections visible: Start a Quote and Quote History<br />Both sections are displayed correctly. UI matches the expected design</p>"
    },
    @{
        id = 182984
        custom_preconds = "<p>User is on the Quotes screen</p>"
        custom_steps = "<p>Observe the Start a Quote section<br />Verify Account ID dropdown is present<br />Verify Products Category search field is present<br />Verify Add Another Product button is present<br />Verify Message field is present<br />Verify Cancel and Get a Quote buttons are present</p>"
        custom_expected = "<p>Section header Start a Quote is displayed<br />Account ID dropdown is visible and populated with name IDs bound to the grower account<br />Product search field is visible with appropriate placeholder text<br />Button is visible and enabled<br />Message text field is visible and marked as optional<br />Both buttons are visible. Cancel is enabled. Get a Quote is enabled or disabled based on form state</p>"
    },
    @{
        id = 182985
        custom_preconds = "<p>User is on the Start a Quote section. Grower account has multiple name IDs</p>"
        custom_steps = "<p>Click the Account ID dropdown<br />Select a specific name ID</p>"
        custom_expected = "<p>Dropdown opens showing all name IDs bound to the grower store account<br />The selected name ID is displayed in the dropdown field. The selection persists</p>"
    },
    @{
        id = 182986
        custom_preconds = "<p>User is on the Start a Quote section with Account ID selected</p>"
        custom_steps = "<p>Click the Products Category search field<br />Type a valid product name<br />Select a product from the results</p>"
        custom_expected = "<p>Search field is active and ready for input<br />Search results appear showing matching products with their descriptions<br />Product is added to the quote with its description displayed. Quantity field appears with the correct unit of measure for that product</p>"
    },
    @{
        id = 182987
        custom_preconds = "<p>User is on the Start a Quote section</p>"
        custom_steps = "<p>Type a product description in the Products Category search field<br />Select a product from the results</p>"
        custom_expected = "<p>Search results appear showing products matching the description<br />Product is added with correct details and appropriate unit of measure</p>"
    },
    @{
        id = 182988
        custom_preconds = "<p>User is on the Start a Quote section</p>"
        custom_steps = "<p>Type a valid item number in the Products Category search field<br />Select the product</p>"
        custom_expected = "<p>Search results display the specific product matching that item number<br />Product is added to the quote with correct description and unit of measure</p>"
    },
    @{
        id = 182989
        custom_preconds = "<p>User is on the Start a Quote section</p>"
        custom_steps = "<p>Search and select a grain-type product<br />Add another product that is liquid such as water<br />Verify each product row shows its own unique unit</p>"
        custom_expected = "<p>Quantity unit of measure displays as Bushels<br />Quantity unit of measure displays as Liter or Gallon<br />Each product line item has its own correct unit of measure independent of others</p>"
    },
    @{
        id = 182990
        custom_preconds = "<p>User has already selected one product in the Start a Quote section</p>"
        custom_steps = "<p>Click Add Another Product button<br />Search and select a second product<br />Click Add Another Product again and add a third product</p>"
        custom_expected = "<p>A new product search row is added below the existing product<br />Second product is added with its own quantity and unit of measure<br />Third product row is added. All three products are displayed with correct details</p>"
    },
    @{
        id = 182991
        custom_preconds = "<p>User has selected a product in the Start a Quote section</p>"
        custom_steps = "<p>Locate the quantity field for the selected product<br />Enter a valid numeric quantity such as 100</p>"
        custom_expected = "<p>Quantity field is visible next to the product with the correct unit of measure label<br />Quantity is accepted and displayed correctly</p>"
    },
    @{
        id = 182992
        custom_preconds = "<p>User has selected product(s) and entered quantities</p>"
        custom_steps = "<p>Click the Message text field<br />Type a note or comment such as Need delivery by next Friday</p>"
        custom_expected = "<p>Message field is active and ready for input<br />Text is accepted and displayed in the message field</p>"
    },
    @{
        id = 182993
        custom_preconds = "<p>User has filled Account ID and selected product(s) with quantities</p>"
        custom_steps = "<p>Click the Get a Quote button<br />Navigate to Quote History section</p>"
        custom_expected = "<p>Quote request is submitted successfully. A success confirmation message is displayed<br />The newly created quote appears at the top of the grid with status Requested and current date</p>"
    },
    @{
        id = 182994
        custom_preconds = "<p>User has partially filled the Start a Quote form (Account ID selected and products added)</p>"
        custom_steps = "<p>Click the Cancel button<br />Verify no API call was made to create a quote</p>"
        custom_expected = "<p>The form is cleared or reset. No quote request is submitted. No entry appears in Quote History<br />No new quote record exists in the backend</p>"
    },
    @{
        id = 182995
        custom_preconds = "<p>User is on the Start a Quote section. Account ID is not selected</p>"
        custom_steps = "<p>Leave Account ID dropdown unselected<br />Select a product and enter quantity<br />Click Get a Quote</p>"
        custom_expected = "<p>No account is selected<br />Product and quantity are accepted<br />Submission is blocked. Validation error is displayed indicating Account ID is required</p>"
    },
    @{
        id = 182996
        custom_preconds = "<p>User is on the Start a Quote section with Account ID selected</p>"
        custom_steps = "<p>Do not search or select any product<br />Click Get a Quote</p>"
        custom_expected = "<p>No product is in the quote<br />Submission is blocked. Validation error indicates at least one product is required</p>"
    },
    @{
        id = 182997
        custom_preconds = "<p>User has selected a product but left the quantity field empty or zero</p>"
        custom_steps = "<p>Select a valid product from search<br />Leave quantity field empty or enter 0<br />Click Get a Quote</p>"
        custom_expected = "<p>Product is added to the quote<br />Quantity shows empty or zero<br />Submission is blocked. Validation error indicates quantity is required and must be greater than zero</p>"
    },
    @{
        id = 182998
        custom_preconds = "<p>User has selected a product</p>"
        custom_steps = "<p>Enter a negative number such as -5 in the quantity field</p>"
        custom_expected = "<p>Input is either rejected or validation error is displayed. Negative quantities are not allowed</p>"
    },
    @{
        id = 182999
        custom_preconds = "<p>User has selected a product</p>"
        custom_steps = "<p>Enter alphabetic characters such as abc in the quantity field<br />Enter special characters in the quantity field</p>"
        custom_expected = "<p>Field rejects non-numeric input or shows a validation error<br />Field rejects special characters or shows a validation error</p>"
    },
    @{
        id = 183000
        custom_preconds = "<p>User has selected a product</p>"
        custom_steps = "<p>Enter an extremely large number such as 99999999999 in the quantity field</p>"
        custom_expected = "<p>Field either limits input length or shows validation for maximum allowed quantity</p>"
    },
    @{
        id = 183001
        custom_preconds = "<p>User has selected a product</p>"
        custom_steps = "<p>Enter a decimal value such as 10.5 in the quantity field</p>"
        custom_expected = "<p>Decimal is either accepted if business allows partial units or rejected with appropriate validation message</p>"
    },
    @{
        id = 183002
        custom_preconds = "<p>User is on the Start a Quote section</p>"
        custom_steps = "<p>Type a random invalid string in the product search field such as xyznonexistent123</p>"
        custom_expected = "<p>No results are displayed. A No products found message or empty state is shown</p>"
    },
    @{
        id = 183003
        custom_preconds = "<p>User has already added Product A to the quote</p>"
        custom_steps = "<p>Click Add Another Product<br />Search and select the same Product A again</p>"
        custom_expected = "<p>New product row is added<br />System either prevents duplicate selection with a message OR allows it depending on business rule. Verify expected behavior</p>"
    },
    @{
        id = 183004
        custom_preconds = "<p>User has filled Account ID and selected product(s) with valid quantities. Message field is left empty</p>"
        custom_steps = "<p>Leave the Message field empty<br />Click Get a Quote</p>"
        custom_expected = "<p>Field remains empty. No validation error since it is optional<br />Quote request is submitted successfully without a message. Quote appears in history</p>"
    },
    @{
        id = 183005
        custom_preconds = "<p>User is on the Start a Quote section</p>"
        custom_steps = "<p>Enter an extremely long text in the Message field with 5000+ characters</p>"
        custom_expected = "<p>Field either enforces a character limit and stops accepting input or truncates. If no limit then text is accepted and saved completely</p>"
    },
    @{
        id = 183006
        custom_preconds = "<p>User is on the Start a Quote section</p>"
        custom_steps = "<p>Enter HTML script tags in Message field<br />Enter SQL injection patterns in the Message field</p>"
        custom_expected = "<p>Input is sanitized. No script execution occurs. Characters are stored as plain text<br />Input is treated as plain text. No backend SQL execution occurs</p>"
    },
    @{
        id = 183007
        custom_preconds = "<p>User is on the Quotes screen. Previous quote requests exist</p>"
        custom_steps = "<p>Observe the Quote History section<br />Verify grid columns are present</p>"
        custom_expected = "<p>Data grid loads with all historical quotes. Loading indicator is shown while data fetches<br />Grid displays: Quote Number, Quote Date, Account ID, Item, Status, and associated dates</p>"
    },
    @{
        id = 183008
        custom_preconds = "<p>User has just submitted a new quote request</p>"
        custom_steps = "<p>Navigate to Quote History section<br />Verify its status</p>"
        custom_expected = "<p>The newly created quote appears at the very top of the grid<br />Status shows Requested with the current date displayed below it</p>"
    },
    @{
        id = 183009
        custom_preconds = "<p>A quote exists with status Requested. The recipient has confirmed or accepted the quote</p>"
        custom_steps = "<p>Refresh the Quote History grid after the quote is confirmed<br />Verify the ordered date is displayed</p>"
        custom_expected = "<p>Quote status changes from Requested to Ordered<br />The ordered date appears below the Ordered status</p>"
    },
    @{
        id = 183010
        custom_preconds = "<p>A quote exists with status Ordered and its order date has passed or expired</p>"
        custom_steps = "<p>View the Quote History after the order date has expired<br />Verify the expiration date is displayed</p>"
        custom_expected = "<p>Quote status changes from Ordered to Expired<br />The expiration date appears below the Expired status</p>"
    },
    @{
        id = 183011
        custom_preconds = "<p>Quotes exist in all three statuses: Requested, Ordered, Expired</p>"
        custom_steps = "<p>Observe a quote with status Requested<br />Observe a quote with status Ordered<br />Observe a quote with status Expired</p>"
        custom_expected = "<p>Requested date is displayed directly below the status<br />Ordered date is displayed directly below the status<br />Expired date is displayed directly below the status</p>"
    },
    @{
        id = 183012
        custom_preconds = "<p>User is on Quote History section with multiple quotes visible</p>"
        custom_steps = "<p>Enter a specific quote number in the Quote Number filter<br />Enter a partial quote number</p>"
        custom_expected = "<p>Grid filters to show only the quote matching that number<br />Grid shows all quotes matching the partial number if partial search is supported</p>"
    },
    @{
        id = 183013
        custom_preconds = "<p>User is on Quote History section with quotes from different dates</p>"
        custom_steps = "<p>Select a specific date in the Quote Date filter<br />Select a date range if supported</p>"
        custom_expected = "<p>Grid filters to show only quotes created on that date<br />Grid shows quotes within the selected date range</p>"
    },
    @{
        id = 183014
        custom_preconds = "<p>User is on Quote History section. Grower has multiple name IDs</p>"
        custom_steps = "<p>Select a specific Account ID from the filter dropdown</p>"
        custom_expected = "<p>Grid filters to show only quotes associated with the selected Account ID</p>"
    },
    @{
        id = 183015
        custom_preconds = "<p>User is on Quote History section with quotes containing different items</p>"
        custom_steps = "<p>Enter a product or item name in the Item filter</p>"
        custom_expected = "<p>Grid filters to show only quotes containing that item</p>"
    },
    @{
        id = 183016
        custom_preconds = "<p>User has applied multiple filters (Quote Number, Date, Account ID, Item)</p>"
        custom_steps = "<p>Click the Clear Filter button<br />Verify Account ID filter after clearing<br />Verify the grid data</p>"
        custom_expected = "<p>All filter fields are cleared<br />Account ID automatically selects All showing all name IDs for the store account. It does NOT remain empty<br />Grid reloads showing all quotes for all Account IDs</p>"
    },
    @{
        id = 183017
        custom_preconds = "<p>User is on Quote History section</p>"
        custom_steps = "<p>Enter a non-existent quote number in the filter<br />Verify grid behavior</p>"
        custom_expected = "<p>Grid shows empty state with appropriate message such as No quotes found<br />No data rows displayed. Export buttons may be disabled or export empty file</p>"
    },
    @{
        id = 183018
        custom_preconds = "<p>User is on Quote History with data visible in the grid</p>"
        custom_steps = "<p>Click Export to PDF button<br />Open the downloaded PDF</p>"
        custom_expected = "<p>PDF file is generated and downloaded<br />PDF contains the grid data matching what is displayed on screen. Formatting is correct and readable</p>"
    },
    @{
        id = 183019
        custom_preconds = "<p>User is on Quote History with data visible in the grid</p>"
        custom_steps = "<p>Click Export to Excel button<br />Open the downloaded Excel file</p>"
        custom_expected = "<p>Excel file is generated and downloaded<br />Excel contains the grid data matching what is displayed on screen. All columns and data are correctly formatted</p>"
    },
    @{
        id = 183020
        custom_preconds = "<p>User has applied filters and a subset of data is displayed in the grid</p>"
        custom_steps = "<p>Click Export to PDF with filters active<br />Click Export to Excel with filters active</p>"
        custom_expected = "<p>PDF contains ONLY the filtered data not all quotes<br />Excel contains ONLY the filtered data not all quotes</p>"
    },
    @{
        id = 183021
        custom_preconds = "<p>Grid shows no data either because no quotes exist or filters return no results</p>"
        custom_steps = "<p>Click Export to PDF<br />Click Export to Excel</p>"
        custom_expected = "<p>Either export is disabled or hidden or an empty header-only PDF is generated with appropriate messaging<br />Either export is disabled or hidden or an empty header-only Excel file is generated</p>"
    },
    @{
        id = 183022
        custom_preconds = "<p>Grower account has only ONE name ID bound to it</p>"
        custom_steps = "<p>Navigate to Start a Quote section<br />Navigate to Quote History filters</p>"
        custom_expected = "<p>Account ID dropdown either auto-selects the single name ID or shows only one option<br />Account ID filter either auto-selects the single ID or shows it as the only option</p>"
    },
    @{
        id = 183023
        custom_preconds = "<p>Grower account has 10+ name IDs bound to it</p>"
        custom_steps = "<p>Open the Account ID dropdown in Start a Quote<br />Open the Account ID filter in Quote History</p>"
        custom_expected = "<p>All name IDs are listed. Dropdown is scrollable if needed. Performance is acceptable<br />All name IDs are listed along with All option</p>"
    },
    @{
        id = 183024
        custom_preconds = "<p>Quotes exist with both single and multiple products</p>"
        custom_steps = "<p>View a quote in history that has a single product<br />View a quote in history that has multiple products</p>"
        custom_expected = "<p>Item column shows the single product correctly<br />All products are displayed either in the same cell or expandable. No product data is lost</p>"
    },
    @{
        id = 183025
        custom_preconds = "<p>User is in the Products Category search field</p>"
        custom_steps = "<p>Type a single character<br />Type the minimum required characters</p>"
        custom_expected = "<p>Verify if search triggers on 1 character or requires minimum such as 3 characters<br />Search results appear after minimum character threshold is met</p>"
    },
    @{
        id = 183026
        custom_preconds = "<p>User has added multiple products to the quote</p>"
        custom_steps = "<p>Locate a remove or delete option on one of the product rows<br />Remove one product</p>"
        custom_expected = "<p>Remove or delete action is available per product row<br />Product is removed from the quote. Remaining products stay intact. Quote can still be submitted with remaining products</p>"
    },
    @{
        id = 183027
        custom_preconds = "<p>Grower has 100+ historical quotes</p>"
        custom_steps = "<p>Navigate to Quote History<br />Navigate to next page or scroll down</p>"
        custom_expected = "<p>Grid loads with pagination or infinite scroll. Not all 100+ records load at once for performance<br />Additional records load correctly. Sorting order is maintained</p>"
    },
    @{
        id = 183028
        custom_preconds = "<p>User is on the Quotes screen</p>"
        custom_steps = "<p>Observe the Start a Quote section header<br />Verify spacing between form fields (Account ID, Products, Quantity, Message)<br />Verify alignment of labels and input fields<br />Verify Cancel and Get a Quote buttons placement</p>"
        custom_expected = "<p>Header text is properly styled, aligned, and visible<br />Consistent spacing between fields. No overlapping elements<br />Labels are left-aligned or per design. Input fields are uniformly sized and aligned<br />Buttons are properly aligned. Proper spacing between them</p>"
    },
    @{
        id = 183029
        custom_preconds = "<p>User is on Start a Quote section</p>"
        custom_steps = "<p>Click the Account ID dropdown<br />Hover over dropdown options<br />Select an option and close dropdown</p>"
        custom_expected = "<p>Dropdown opens with smooth animation. Options are readable and properly spaced<br />Hover state is visually indicated with highlight or color change<br />Selected value is displayed in the field. Dropdown closes cleanly</p>"
    },
    @{
        id = 183030
        custom_preconds = "<p>User is on Start a Quote section</p>"
        custom_steps = "<p>Observe the Product search field before interaction<br />Click or focus the search field<br />Type a search term and observe results dropdown</p>"
        custom_expected = "<p>Placeholder text is visible such as Search by name, description, or item number<br />Field shows active or focus state with border color change or highlight<br />Results appear in a dropdown below the field. Dropdown does not overflow or cover critical UI elements</p>"
    },
    @{
        id = 183031
        custom_preconds = "<p>User has selected a product from search results</p>"
        custom_steps = "<p>Observe the selected product row<br />Verify the unit of measure label<br />Verify visual separation between multiple product rows</p>"
        custom_expected = "<p>Product name and description is clearly displayed. Quantity field is visible with unit of measure label next to it<br />Unit label such as Bushels or Liters is displayed adjacent to the quantity field and is not editable<br />Each product row is visually distinct with border, spacing, or alternating background</p>"
    },
    @{
        id = 183032
        custom_preconds = "<p>User is on Start a Quote section</p>"
        custom_steps = "<p>Observe the Add Another Product button before any product is added<br />Add a product and observe button position<br />Hover over the button</p>"
        custom_expected = "<p>Button is visible and enabled<br />Button remains accessible below the last product row. Does not shift unexpectedly<br />Hover state is visually indicated</p>"
    },
    @{
        id = 183033
        custom_preconds = "<p>User is on Start a Quote section</p>"
        custom_steps = "<p>Observe the Message field<br />Type a long message that exceeds one line<br />Verify character count indicator if present</p>"
        custom_expected = "<p>Field is clearly labeled as optional. Adequate height for multi-line text<br />Field expands or allows scrolling within the field. Text wraps properly<br />Character count or remaining characters shown if applicable per design</p>"
    },
    @{
        id = 183034
        custom_preconds = "<p>User is on Start a Quote section with data entered</p>"
        custom_steps = "<p>Hover over Cancel button<br />Click Cancel button</p>"
        custom_expected = "<p>Hover state is visually indicated with color change or underline<br />Button shows click or active state. Action triggers immediately without delay</p>"
    },
    @{
        id = 183035
        custom_preconds = "<p>User is on Start a Quote section</p>"
        custom_steps = "<p>Observe Get a Quote button when form is incomplete with missing required fields<br />Fill all required fields and observe button<br />Click the button</p>"
        custom_expected = "<p>Button is either disabled and greyed out or enabled but validates on click<br />Button is fully enabled with primary action styling such as solid color and prominent appearance<br />Loading indicator appears on or near the button. Button is disabled during submission to prevent double-click</p>"
    },
    @{
        id = 183036
        custom_preconds = "<p>User attempts to submit the quote with missing required fields</p>"
        custom_steps = "<p>Click Get a Quote with Account ID not selected<br />Click Get a Quote with no product selected<br />Click Get a Quote with product selected but no quantity<br />Fix one error and re-submit</p>"
        custom_expected = "<p>Inline error message appears near the Account ID field. Error text is red or styled per design system<br />Error message indicates product selection is required. Message appears in correct location<br />Error appears next to the specific quantity field that is empty<br />Fixed field error disappears. Remaining errors stay visible</p>"
    },
    @{
        id = 183037
        custom_preconds = "<p>User is on Quote History section with data</p>"
        custom_steps = "<p>Verify grid column headers<br />Verify row height and text truncation<br />Verify alternating row colors if applicable</p>"
        custom_expected = "<p>All expected columns are displayed: Quote Number, Quote Date, Account ID, Item, Status. Headers are properly aligned<br />Row height is consistent. Long text is truncated with ellipsis or wrapped properly<br />Rows have alternating background for readability or consistent styling per design</p>"
    },
    @{
        id = 183038
        custom_preconds = "<p>Quote History contains quotes in all statuses (Requested, Ordered, Expired)</p>"
        custom_steps = "<p>Observe Requested status display<br />Observe Ordered status display<br />Observe Expired status display<br />Verify dates below each status</p>"
        custom_expected = "<p>Status text is visible with associated color or badge such as blue or neutral<br />Status text is visible with associated color or badge such as green or success<br />Status text is visible with associated color or badge such as red or grey<br />Dates are displayed in smaller or secondary text directly below the status. Proper date format is used</p>"
    },
    @{
        id = 183039
        custom_preconds = "<p>User is on Quote History section</p>"
        custom_steps = "<p>Verify filter fields are displayed in a row or group above the grid<br />Verify Clear Filter button position<br />Verify filter field labels</p>"
        custom_expected = "<p>Quote Number, Quote Date, Account ID, and Item filters are visible and properly aligned<br />Clear Filter button is positioned logically at end of filter row or below filters<br />Each filter has a clear label or placeholder text indicating its purpose</p>"
    },
    @{
        id = 183040
        custom_preconds = "<p>User is on Quote History section</p>"
        custom_steps = "<p>Verify Export to PDF button location<br />Verify Export to Excel button location<br />Hover over export buttons</p>"
        custom_expected = "<p>Button is positioned above or near the grid per design. Clearly identifiable with icon or text<br />Button is next to Export to PDF. Consistent styling with PDF button<br />Hover states are visually indicated</p>"
    },
    @{
        id = 183041
        custom_preconds = "<p>Grower has no previous quote requests</p>"
        custom_steps = "<p>Navigate to Quote History section<br />Verify filters and export buttons in empty state</p>"
        custom_expected = "<p>An appropriate empty state is shown such as No quotes found or illustration with message<br />Filters may be hidden or disabled. Export buttons are disabled or hidden when no data exists</p>"
    },
    @{
        id = 183042
        custom_preconds = "<p>User navigates to Quotes screen or performs an action</p>"
        custom_steps = "<p>Observe page during initial load<br />Apply a filter and observe grid<br />Submit a quote and observe<br />Trigger product search</p>"
        custom_expected = "<p>Loading spinner or skeleton screen is displayed while data fetches<br />Grid shows loading indicator while filtering data<br />Submit button shows loading state. Form is not interactable during submission<br />Search field shows loading indicator while fetching results</p>"
    },
    @{
        id = 183043
        custom_preconds = "<p>User performs various actions on the Quotes screen</p>"
        custom_steps = "<p>Submit a quote successfully<br />Trigger an error such as network failure during submit</p>"
        custom_expected = "<p>Success message or toast appears such as Quote request submitted successfully. Message auto-dismisses or has close button<br />Error message or toast appears with appropriate text. Styled in red or error color. Does not block entire UI</p>"
    },
    @{
        id = 183044
        custom_preconds = "<p>User accesses the Quotes screen on a tablet or resized browser</p>"
        custom_steps = "<p>Resize browser to tablet width around 768px<br />Verify Quote History grid at tablet width<br />Verify buttons remain accessible</p>"
        custom_expected = "<p>Layout adjusts. Form fields stack or resize appropriately. No horizontal overflow<br />Grid columns adjust with horizontal scroll, column hiding, or responsive layout. Data remains readable<br />Cancel, Get a Quote, Export, and filter buttons are still clickable and not cut off</p>"
    },
    @{
        id = 183045
        custom_preconds = "<p>User is on the Quotes screen using only keyboard</p>"
        custom_steps = "<p>Press Tab to navigate through form fields<br />Open Account ID dropdown with keyboard using Enter or Space<br />Navigate through Quote History filters with Tab</p>"
        custom_expected = "<p>Focus moves in logical order: Account ID then Product search then Quantity then Message then Cancel then Get a Quote<br />Dropdown opens. Arrow keys navigate options. Enter selects<br />Focus moves through each filter field in order. Clear Filter is reachable via Tab</p>"
    },
    @{
        id = 183046
        custom_preconds = "<p>User is on Start a Quote section</p>"
        custom_steps = "<p>Hover over field labels or info icons if present<br />Verify optional indicator on Message field</p>"
        custom_expected = "<p>Tooltip or help text appears explaining the field purpose<br />Message field clearly indicates it is optional via label text, italic style, or lighter color</p>"
    }
)

$successCount = 0
$failCount = 0

foreach ($tc in $testCases) {
    $body = @{
        custom_preconds = $tc.custom_preconds
        custom_steps = $tc.custom_steps
        custom_expected = $tc.custom_expected
    } | ConvertTo-Json -Depth 5

    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/update_case/$($tc.id)" -Method POST -Headers $headers -Body $body
        Write-Host "UPDATED: $($response.title) (ID: $($response.id))" -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "FAILED: ID $($tc.id) - $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
    Start-Sleep -Milliseconds 500
}

Write-Host "`n===== SUMMARY =====" -ForegroundColor Cyan
Write-Host "Updated: $successCount | Failed: $failCount" -ForegroundColor Cyan
