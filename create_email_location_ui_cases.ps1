$baseUrl = "https://culturatech.testrail.io/index.php?/api/v2"
$sectionId = 21786
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:TESTRAIL_USER):$($env:TESTRAIL_PASS)"))
$headers = @{ "Authorization" = "Basic $auth"; "Content-Type" = "application/json" }

$testCases = @(
    @{
        title = "Verify Email List Display on Page Load"
        custom_preconds = "<p>User is logged in as a Super Admin<br />At least one email is configured for new user signup notifications<br />User navigates to the email notification settings screen</p>"
        custom_steps = "<p>Observe the email notification settings screen on load<br />Verify all configured emails are listed<br />Verify each email row is clearly readable and distinguishable</p>"
        custom_expected = "<p>All configured notification emails are displayed in a list format<br />Each email address is fully visible and not truncated<br />Rows are properly spaced and separated</p>"
    },
    @{
        title = "Verify Attach Location Toggle Default State"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />An email entry exists without any location assigned</p>"
        custom_steps = "<p>Observe the Attach Location toggle for an email entry with no locations<br />Verify the toggle's default position<br />Verify the location field is not visible when toggle is off</p>"
        custom_expected = "<p>The Attach Location toggle defaults to the OFF/disabled state<br />No location dropdown or field is visible when toggle is off<br />The toggle is clearly labeled or has a tooltip indicating its purpose</p>"
    },
    @{
        title = "Verify Location Dropdown Appears When Toggle is Enabled"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />An email entry exists with the Attach Location toggle in OFF state</p>"
        custom_steps = "<p>Click the Attach Location toggle to enable it<br />Observe the UI change below or beside the email entry</p>"
        custom_expected = "<p>A location dropdown/field appears immediately after enabling the toggle<br />The dropdown is properly aligned with the email entry<br />The field has a placeholder text indicating the user should search or select a location</p>"
    },
    @{
        title = "Verify Location Dropdown Search Field UI"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Attach Location toggle is enabled for an email entry<br />The location dropdown is visible</p>"
        custom_steps = "<p>Click on the location dropdown<br />Observe the search input field inside the dropdown<br />Verify placeholder text is present<br />Verify the dropdown list appears below the search field</p>"
        custom_expected = "<p>The dropdown opens with a search input at the top<br />Placeholder text guides the user (e.g., 'Search location...')<br />Available locations are listed below the search field<br />The dropdown has a scrollbar if the list exceeds visible area</p>"
    },
    @{
        title = "Verify Selected Location Display as Chip/Tag"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Attach Location toggle is enabled<br />User has selected a location from the dropdown</p>"
        custom_steps = "<p>Select a location from the dropdown<br />Observe how the selected location is displayed in the UI<br />Verify the remove/delete icon on the location chip</p>"
        custom_expected = "<p>The selected location appears as a chip, tag, or badge element<br />The location name is fully readable within the chip<br />A clear remove/delete icon (X) is visible on or near the chip<br />The chip styling is consistent with the application design system</p>"
    },
    @{
        title = "Verify Multiple Location Chips Alignment and Wrapping"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry has 4 or more locations assigned</p>"
        custom_steps = "<p>Observe the email entry with multiple locations<br />Verify how location chips are arranged when they exceed one row<br />Resize the browser to a narrower width<br />Observe the chip layout behavior</p>"
        custom_expected = "<p>Multiple location chips wrap properly to the next line when space is insufficient<br />Chips maintain consistent size and spacing<br />No chips are cut off or overlap each other<br />The layout remains clean and readable at different widths</p>"
    },
    @{
        title = "Verify Add Another Email Button Placement and Style"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen</p>"
        custom_steps = "<p>Scroll to the bottom of the email list (if needed)<br />Locate the 'Add Another Email' button<br />Observe its position, color, and style<br />Verify it is distinguishable from other actions</p>"
        custom_expected = "<p>The 'Add Another Email' button is clearly visible below the existing email entries<br />Button style matches the application design (color, font, size)<br />Button text is clear and readable<br />Button has proper hover/focus state</p>"
    },
    @{
        title = "Verify New Email Row Appears After Clicking Add Another Email"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />At least one email entry already exists</p>"
        custom_steps = "<p>Click the 'Add Another Email' button<br />Observe the new row that appears<br />Verify it has the same structure as existing email rows</p>"
        custom_expected = "<p>A new empty email row is added at the bottom of the list<br />The new row contains an email input field and Attach Location toggle<br />The row styling is consistent with existing rows<br />The page scrolls to show the new entry if needed</p>"
    },
    @{
        title = "Verify Delete Location Icon Hover State"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry has at least one location chip displayed</p>"
        custom_steps = "<p>Hover over the delete/remove icon on a location chip<br />Observe any visual feedback (color change, tooltip, cursor)</p>"
        custom_expected = "<p>The cursor changes to a pointer on hover<br />The delete icon shows a visual change (color highlight or tooltip)<br />A tooltip or title attribute shows 'Remove' or 'Delete' on hover<br />The feedback clearly indicates the action is clickable</p>"
    },
    @{
        title = "Verify Empty State When No Locations Are Assigned"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry exists with Attach Location toggle enabled<br />No locations have been selected yet</p>"
        custom_steps = "<p>Observe the location field area when no locations are selected<br />Verify the placeholder or empty state messaging</p>"
        custom_expected = "<p>The location field shows a clear placeholder (e.g., 'Select location...' or 'No locations added')<br />The area is not collapsed or hidden<br />The dropdown remains accessible for the user to add locations</p>"
    },
    @{
        title = "Verify Save and Cancel Buttons Visibility"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />User has made changes to email or location configuration</p>"
        custom_steps = "<p>Observe the Save and Cancel buttons<br />Verify their position on the screen<br />Verify button labels and styling</p>"
        custom_expected = "<p>Save and Cancel buttons are clearly visible<br />Save button has a primary style (e.g., filled, prominent color)<br />Cancel button has a secondary style (e.g., outlined or neutral)<br />Buttons are positioned consistently (bottom of form or fixed footer)</p>"
    },
    @{
        title = "Verify Location Dropdown No Results State"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Attach Location toggle is enabled<br />The location dropdown is open</p>"
        custom_steps = "<p>Type a random string that does not match any location in the search field<br />Observe the dropdown state</p>"
        custom_expected = "<p>The dropdown displays a 'No results found' or equivalent empty state message<br />The message is styled appropriately and not an error<br />The dropdown remains open allowing the user to modify their search<br />No option is selectable</p>"
    },
    @{
        title = "Verify Validation Error Message Styling for Empty Location"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Attach Location toggle is enabled for an email<br />No location has been selected</p>"
        custom_steps = "<p>Click Save without selecting a location<br />Observe the validation error message displayed</p>"
        custom_expected = "<p>A validation error message appears near the location field<br />The error message text is clear (e.g., 'Location is required')<br />Error styling uses a red or warning color<br />The location field border or highlight indicates the error state</p>"
    }
)

$successCount = 0
$failCount = 0

foreach ($tc in $testCases) {
    $body = @{
        title = $tc.title
        template_id = 1
        custom_preconds = $tc.custom_preconds
        custom_steps = $tc.custom_steps
        custom_expected = $tc.custom_expected
    } | ConvertTo-Json -Depth 5

    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/add_case/$sectionId" -Method POST -Headers $headers -Body $body
        Write-Host "CREATED: C$($response.id) - $($response.title)" -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "FAILED: $($tc.title) - $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
    Start-Sleep -Milliseconds 400
}

Write-Host "`n===== SUMMARY =====" -ForegroundColor Cyan
Write-Host "Created: $successCount | Failed: $failCount" -ForegroundColor Cyan
