$baseUrl = "https://culturatech.testrail.io/index.php?/api/v2"
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:TESTRAIL_USER):$($env:TESTRAIL_PASS)"))
$headers = @{ "Authorization" = "Basic $auth"; "Content-Type" = "application/json" }

$updates = @(
    @{
        id = 180783
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />The application is accessible and functional<br />User has access to the Remarks Management section</p>"
            custom_steps = "<p>Navigate to the Remarks Management section from the admin menu<br />Locate and click on the Sales Person Remark Management option<br />Wait for the screen to load completely</p>"
            custom_expected = "<p>The Sales Person Remark Management screen loads successfully<br />The screen layout matches the Figma mockup (header, table/list, action buttons)<br />No errors are displayed during navigation</p>"
        }
    },
    @{
        id = 180784
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />The screen has loaded completely</p>"
            custom_steps = "<p>Observe the page header/title<br />Verify the presence of an Add button or equivalent action to create a new mapping<br />Verify the table/list displays columns for Remark Code and Salesperson<br />Verify action buttons (Edit, Delete) are available for each row<br />Compare the overall layout with the Figma mockup</p>"
            custom_expected = "<p>Page title is displayed correctly<br />Add button is visible and enabled<br />Table/list headers match the expected columns (Remark Code, Salesperson)<br />Edit and Delete actions are available per row<br />Layout, spacing, and alignment match the Figma mockup</p>"
        }
    },
    @{
        id = 180785
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />The screen has loaded completely</p>"
            custom_steps = "<p>Click the Add button<br />Enter a valid Remark Code in the Remark Code field<br />Enter or select a valid AGRIS Salesperson in the Salesperson field<br />Click Save/Submit<br />Verify the new mapping appears in the list<br />Refresh the page and verify the mapping persists</p>"
            custom_expected = "<p>A form/dialog opens for adding a new mapping<br />Both fields accept valid input without errors<br />On save, the new mapping appears in the list/table<br />A success confirmation message is displayed<br />The data persists and is visible after page refresh</p>"
        }
    },
    @{
        id = 180786
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />The Add mapping form/dialog is open</p>"
            custom_steps = "<p>Leave the Remark Code field empty<br />Enter a valid Salesperson in the Salesperson field<br />Click Save/Submit</p>"
            custom_expected = "<p>Save is blocked or an inline validation error is displayed<br />Error message indicates Remark Code is required<br />No record is created in the system</p>"
        }
    },
    @{
        id = 180787
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />The Add mapping form/dialog is open</p>"
            custom_steps = "<p>Enter a valid Remark Code in the Remark Code field<br />Leave the Salesperson field empty<br />Click Save/Submit</p>"
            custom_expected = "<p>Save is blocked or an inline validation error is displayed<br />Error message indicates Salesperson is required<br />No record is created in the system</p>"
        }
    },
    @{
        id = 180788
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />The Add mapping form/dialog is open</p>"
            custom_steps = "<p>Leave the Remark Code field empty<br />Leave the Salesperson field empty<br />Click Save/Submit</p>"
            custom_expected = "<p>Save is blocked<br />Validation errors are shown for all required fields<br />No record is created in the system</p>"
        }
    },
    @{
        id = 180789
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />A mapping with a specific Remark Code already exists in the system</p>"
            custom_steps = "<p>Click the Add button<br />Enter the same Remark Code that already exists in the Remark Code field<br />Enter a valid Salesperson in the Salesperson field<br />Click Save/Submit</p>"
            custom_expected = "<p>An error or validation message indicates the Remark Code already exists<br />The duplicate record is not created<br />The existing mapping remains unchanged</p>"
        }
    },
    @{
        id = 180790
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />At least one mapping exists in the list</p>"
            custom_steps = "<p>Locate an existing mapping in the table<br />Click the Edit action for that row<br />Verify the form opens pre-populated with existing values<br />Modify the Remark Code or Salesperson value<br />Click Save/Submit<br />Verify the updated values are reflected in the list</p>"
            custom_expected = "<p>The edit form/dialog opens pre-populated with the existing Remark Code and Salesperson values<br />Fields accept the new values<br />On save, the updated values are reflected in the list<br />A success confirmation message is displayed</p>"
        }
    },
    @{
        id = 180791
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />User has clicked Edit on an existing mapping</p>"
            custom_steps = "<p>Modify a field value in the edit form<br />Click Cancel or close the dialog without saving</p>"
            custom_expected = "<p>The dialog/form closes<br />The original values remain unchanged in the list<br />No update is made to the backend</p>"
        }
    },
    @{
        id = 180792
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />At least one mapping exists in the list</p>"
            custom_steps = "<p>Locate an existing mapping in the table<br />Click the Delete action for that row<br />Observe the confirmation prompt<br />Click Confirm/Yes to proceed with deletion<br />Verify the mapping is removed from the list<br />Refresh the page and verify the record is gone</p>"
            custom_expected = "<p>A confirmation dialog/prompt appears before deletion<br />On confirm, the mapping is removed from the list<br />A success confirmation message is displayed<br />The record is no longer visible after page refresh</p>"
        }
    },
    @{
        id = 180793
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen<br />User has clicked Delete on a mapping and the confirmation prompt is displayed</p>"
            custom_steps = "<p>Click Cancel or No on the confirmation prompt</p>"
            custom_expected = "<p>The confirmation prompt closes<br />The mapping remains in the list unchanged<br />No deletion occurs</p>"
        }
    },
    @{
        id = 180794
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />Multiple Remark Code mappings exist in the system</p>"
            custom_steps = "<p>Navigate to the Sales Person Remark Management screen<br />Observe the table/list while data is loading<br />Wait for loading to complete<br />Verify all existing mappings are displayed</p>"
            custom_expected = "<p>A loading indicator is shown while data is being fetched<br />All existing mappings are displayed in the table after loading<br />Data displayed matches what is stored in the backend</p>"
        }
    },
    @{
        id = 180795
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />No Remark Code mappings exist in the system</p>"
            custom_steps = "<p>Navigate to the Sales Person Remark Management screen<br />Observe the table/list area</p>"
            custom_expected = "<p>An appropriate empty state message is displayed (e.g., 'No mappings found' or similar)<br />The Add button is still visible and functional<br />No errors are displayed</p>"
        }
    },
    @{
        id = 180796
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Add or Edit mapping form</p>"
            custom_steps = "<p>Enter special characters in the Remark Code field (e.g., !@#$%^&amp;*)<br />Enter excessively long text in both fields exceeding expected limits<br />Enter leading and trailing spaces in the fields<br />Attempt to save after each entry</p>"
            custom_expected = "<p>Special characters are handled appropriately (accepted or rejected with clear validation)<br />Fields respect maximum character limits if defined<br />Leading/trailing spaces are trimmed or validated with appropriate messaging</p>"
        }
    },
    @{
        id = 180797
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen</p>"
            custom_steps = "<p>Click Add and enter valid data for Remark Code and Salesperson<br />Click Save/Submit<br />Verify the success message appears<br />Refresh the browser page<br />Verify the newly added mapping is still displayed</p>"
            custom_expected = "<p>Save is successful with a confirmation message<br />The newly added mapping persists after page refresh<br />The data returned from the backend matches what was submitted</p>"
        }
    },
    @{
        id = 180798
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Add mapping form<br />Backend is unavailable or experiencing errors (simulate via network interruption or DevTools throttling)</p>"
            custom_steps = "<p>Enter valid data in all fields<br />Simulate a network error or backend unavailability<br />Click Save/Submit</p>"
            custom_expected = "<p>An appropriate error message is displayed to the user<br />The form remains open with the entered data intact<br />No partial or corrupt data is saved to the system</p>"
        }
    },
    @{
        id = 180799
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in with a non-administrator role<br />The application is accessible</p>"
            custom_steps = "<p>Attempt to navigate to the Sales Person Remark Management screen via the admin menu<br />If the menu option is not visible, attempt to access the screen URL directly in the browser</p>"
            custom_expected = "<p>The menu option is not visible for non-admin users OR access is denied<br />If accessed via direct URL, a proper 'Unauthorized' or 'Access Denied' message is displayed<br />No data from the management screen is exposed</p>"
        }
    },
    @{
        id = 180800
        body = @{
            template_id = 1
            custom_preconds = "<p>User is logged in as an Administrator<br />User is on the Sales Person Remark Management screen</p>"
            custom_steps = "<p>Resize the browser window to desktop width (1920px)<br />Resize the browser window to tablet width (768px)<br />Resize the browser window to mobile width (375px)<br />Observe the table, buttons, and form behavior at each width</p>"
            custom_expected = "<p>UI elements remain usable and properly aligned at all widths<br />Table adjusts appropriately (horizontal scroll, column wrap, or responsive layout)<br />Buttons remain accessible and clickable<br />No content is cut off or overlapping</p>"
        }
    }
)

$successCount = 0
$failCount = 0

foreach ($update in $updates) {
    $body = $update.body | ConvertTo-Json -Depth 5
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/update_case/$($update.id)" -Method POST -Headers $headers -Body $body
        Write-Host "UPDATED: C$($update.id) - $($response.title)" -ForegroundColor Green
        $successCount++
    } catch {
        $errorBody = $_.ErrorDetails.Message
        Write-Host "FAILED: C$($update.id) - $($_.Exception.Message) | $errorBody" -ForegroundColor Red
        $failCount++
    }
    Start-Sleep -Milliseconds 300
}

Write-Host "`n===== SUMMARY =====" -ForegroundColor Cyan
Write-Host "Updated: $successCount | Failed: $failCount" -ForegroundColor Cyan
