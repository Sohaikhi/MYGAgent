$baseUrl = "https://culturatech.testrail.io/index.php?/api/v2"
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:TESTRAIL_USER):$($env:TESTRAIL_PASS)"))
$headers = @{ "Authorization" = "Basic $auth"; "Content-Type" = "application/json" }

$updates = @(
    @{
        id = 180783
        body = @{
            template_id = 2
            custom_preconds = "User is logged in as an Administrator"
            custom_steps_separated = @(
                @{ content = "Navigate to the Remarks Management section from the admin menu"; expected = "Remarks Management section is accessible" }
                @{ content = "Locate and click on the Sales Person Remark Management option"; expected = "The Sales Person Remark Management screen loads successfully. The screen layout matches the Figma mockup (header, table/list, action buttons)" }
            )
        }
    },
    @{
        id = 180784
        body = @{
            template_id = 2
            custom_preconds = "User is on the Sales Person Remark Management screen"
            custom_steps_separated = @(
                @{ content = "Observe the page header/title"; expected = "Page title is displayed correctly" }
                @{ content = "Verify the presence of an Add button (or equivalent action to create a new mapping)"; expected = "Add button is visible and enabled" }
                @{ content = "Verify the table/list displays columns for Remark Code and Salesperson"; expected = "Table/list headers match the expected columns (Remark Code, Salesperson)" }
                @{ content = "Verify action buttons (Edit, Delete) are available for each row"; expected = "Edit and Delete actions are available per row. Layout, spacing, and alignment match the Figma mockup" }
            )
        }
    },
    @{
        id = 180785
        body = @{
            template_id = 2
            custom_preconds = "User is on the Sales Person Remark Management screen"
            custom_steps_separated = @(
                @{ content = "Click the Add button"; expected = "A form/dialog opens for adding a new mapping" }
                @{ content = "Enter a valid Remark Code in the Remark Code field"; expected = "Remark Code field accepts input" }
                @{ content = "Enter or select a valid AGRIS Salesperson"; expected = "Salesperson field accepts input/selection" }
                @{ content = "Click Save/Submit"; expected = "The new mapping appears in the list/table. A success confirmation is displayed. The data persists after page refresh" }
            )
        }
    },
    @{
        id = 180786
        body = @{
            template_id = 2
            custom_preconds = "User is on the Add mapping form/dialog"
            custom_steps_separated = @(
                @{ content = "Leave the Remark Code field empty"; expected = "Field remains empty" }
                @{ content = "Enter a valid Salesperson"; expected = "Salesperson field accepts input" }
                @{ content = "Click Save/Submit"; expected = "Save is blocked or an inline validation error is displayed. Error message indicates Remark Code is required. No record is created" }
            )
        }
    },
    @{
        id = 180787
        body = @{
            template_id = 2
            custom_preconds = "User is on the Add mapping form/dialog"
            custom_steps_separated = @(
                @{ content = "Enter a valid Remark Code"; expected = "Remark Code field accepts input" }
                @{ content = "Leave the Salesperson field empty"; expected = "Field remains empty" }
                @{ content = "Click Save/Submit"; expected = "Save is blocked or an inline validation error is displayed. Error message indicates Salesperson is required. No record is created" }
            )
        }
    },
    @{
        id = 180788
        body = @{
            template_id = 2
            custom_preconds = "User is on the Add mapping form/dialog"
            custom_steps_separated = @(
                @{ content = "Leave all fields empty"; expected = "All fields remain empty" }
                @{ content = "Click Save/Submit"; expected = "Save is blocked. Validation errors are shown for all required fields. No record is created" }
            )
        }
    },
    @{
        id = 180789
        body = @{
            template_id = 2
            custom_preconds = "A mapping with Remark Code 'RC001' already exists in the system"
            custom_steps_separated = @(
                @{ content = "Click Add button"; expected = "Add form/dialog opens" }
                @{ content = "Enter 'RC001' in the Remark Code field (same as existing)"; expected = "Field accepts input" }
                @{ content = "Enter a Salesperson"; expected = "Salesperson field accepts input" }
                @{ content = "Click Save/Submit"; expected = "An error/validation message indicates the Remark Code already exists. The duplicate record is not created" }
            )
        }
    },
    @{
        id = 180790
        body = @{
            template_id = 2
            custom_preconds = "At least one mapping exists in the list"
            custom_steps_separated = @(
                @{ content = "Locate an existing mapping in the table"; expected = "Mapping row is visible with current values" }
                @{ content = "Click the Edit action for that row"; expected = "The edit form/dialog opens pre-populated with existing values" }
                @{ content = "Modify the Remark Code or Salesperson value"; expected = "Field accepts the new value" }
                @{ content = "Click Save/Submit"; expected = "The updated values are reflected in the list. A success confirmation is displayed" }
            )
        }
    },
    @{
        id = 180791
        body = @{
            template_id = 2
            custom_preconds = "User has clicked Edit on an existing mapping"
            custom_steps_separated = @(
                @{ content = "Modify a field value in the edit form"; expected = "Field value is changed" }
                @{ content = "Click Cancel or close the dialog"; expected = "The dialog/form closes. The original values remain unchanged in the list. No API call is made to update" }
            )
        }
    },
    @{
        id = 180792
        body = @{
            template_id = 2
            custom_preconds = "At least one mapping exists in the list"
            custom_steps_separated = @(
                @{ content = "Locate an existing mapping in the table"; expected = "Mapping row is visible" }
                @{ content = "Click the Delete action for that row"; expected = "A confirmation dialog/prompt appears before deletion" }
                @{ content = "Confirm deletion in the confirmation prompt"; expected = "The mapping is removed from the list. A success confirmation is displayed. The record is no longer visible after page refresh" }
            )
        }
    },
    @{
        id = 180793
        body = @{
            template_id = 2
            custom_preconds = "User has clicked Delete on a mapping and the confirmation prompt is displayed"
            custom_steps_separated = @(
                @{ content = "Click Cancel on the confirmation prompt"; expected = "The confirmation prompt closes. The mapping remains in the list unchanged" }
            )
        }
    },
    @{
        id = 180794
        body = @{
            template_id = 2
            custom_preconds = "Multiple Remark Code mappings exist in the system"
            custom_steps_separated = @(
                @{ content = "Navigate to the Sales Person Remark Management screen"; expected = "A loading indicator is shown while data is fetched" }
                @{ content = "Observe the table/list after loading completes"; expected = "All existing mappings are displayed in the table. Data matches what is stored in the backend" }
            )
        }
    },
    @{
        id = 180795
        body = @{
            template_id = 2
            custom_preconds = "No Remark Code mappings exist in the system"
            custom_steps_separated = @(
                @{ content = "Navigate to the Sales Person Remark Management screen"; expected = "An appropriate empty state message is displayed (e.g., 'No mappings found'). The Add button is still visible and functional" }
            )
        }
    },
    @{
        id = 180796
        body = @{
            template_id = 2
            custom_preconds = "User is on the Add/Edit mapping form"
            custom_steps_separated = @(
                @{ content = "Enter special characters in the Remark Code field"; expected = "Special characters are handled appropriately (accepted or rejected with validation)" }
                @{ content = "Enter excessively long text in both fields"; expected = "Fields respect maximum character limits (if defined)" }
                @{ content = "Attempt to enter leading/trailing spaces"; expected = "Input is trimmed or validated for whitespace" }
            )
        }
    },
    @{
        id = 180797
        body = @{
            template_id = 2
            custom_preconds = "User is on the Add mapping form"
            custom_steps_separated = @(
                @{ content = "Add a new mapping with valid data and click Save"; expected = "Save is successful with confirmation message" }
                @{ content = "Refresh the page"; expected = "The newly added mapping persists after refresh. The data returned from the backend matches what was submitted" }
            )
        }
    },
    @{
        id = 180798
        body = @{
            template_id = 2
            custom_preconds = "Backend is unavailable or returns an error (simulate via network interruption or invalid data)"
            custom_steps_separated = @(
                @{ content = "Attempt to save a mapping while the backend is unavailable or returns an error"; expected = "An appropriate error message is displayed to the user. The form remains open with entered data intact. No partial/corrupt data is saved" }
            )
        }
    },
    @{
        id = 180799
        body = @{
            template_id = 2
            custom_preconds = "User is logged in with a non-administrator role"
            custom_steps_separated = @(
                @{ content = "Attempt to navigate to the Sales Person Remark Management screen via menu"; expected = "The menu option is not visible or access is denied" }
                @{ content = "Attempt to access the screen URL directly"; expected = "A proper 'Unauthorized' or 'Access Denied' message is shown" }
            )
        }
    },
    @{
        id = 180800
        body = @{
            template_id = 2
            custom_preconds = "User is on the Sales Person Remark Management screen"
            custom_steps_separated = @(
                @{ content = "Resize the browser window to various widths (desktop, tablet, mobile)"; expected = "UI elements remain usable and properly aligned" }
                @{ content = "Observe table, buttons, and form behavior at smaller widths"; expected = "Table adjusts (scroll, wrap, or responsive layout). Buttons remain accessible" }
            )
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
