$baseUrl = "https://culturatech.testrail.io/index.php?/api/v2"
$sectionId = 21786
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($env:TESTRAIL_USER):$($env:TESTRAIL_PASS)"))
$headers = @{ "Authorization" = "Basic $auth"; "Content-Type" = "application/json" }

$testCases = @(
    # --- UI TEST CASES ---
    @{
        title = "Verify Email Notification Settings Screen Layout"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User has navigated to the email notification settings for new user signups</p>"
        custom_steps = "<p>Observe the page layout and elements<br />Verify the list of configured notification emails is displayed<br />Verify each email row shows the email address and associated locations<br />Verify the 'Add Another Email' button is visible<br />Verify the 'Attach Location' toggle button is present for each email entry</p>"
        custom_expected = "<p>The screen displays all configured notification emails<br />Each email row shows the email address and its assigned locations<br />'Add Another Email' button is visible and enabled<br />'Attach Location' toggle is visible for each email entry<br />Layout is clean and aligned properly</p>"
    },
    @{
        title = "Verify Location Dropdown is Searchable"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />An email entry exists with the Attach Location toggle enabled</p>"
        custom_steps = "<p>Click on the location dropdown field<br />Type a partial location name in the search field<br />Observe the dropdown results as you type</p>"
        custom_expected = "<p>The location dropdown opens with a search input<br />As the user types, the dropdown filters results to match the search text<br />Only locations matching the search term are displayed<br />Results update dynamically with each keystroke</p>"
    },
    @{
        title = "Verify Attach Location Toggle Button Visibility and Behavior"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />At least one email entry exists</p>"
        custom_steps = "<p>Locate the 'Attach Location' toggle button next to an email entry<br />Observe the toggle default state<br />Click the toggle to enable it<br />Observe the UI change after enabling<br />Click the toggle again to disable it<br />Observe the UI change after disabling</p>"
        custom_expected = "<p>Toggle button is clearly visible next to each email entry<br />When disabled, the location field/dropdown is not shown<br />When enabled, the location field/dropdown becomes visible and ready for input<br />When toggled back to disabled, the location field hides again</p>"
    },
    @{
        title = "Verify Add Another Email Button"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen</p>"
        custom_steps = "<p>Click the 'Add Another Email' button<br />Observe the new email entry row that appears</p>"
        custom_expected = "<p>A new empty email entry row is added to the list<br />The new row includes an email field and an Attach Location toggle<br />The toggle defaults to disabled for the new entry<br />The button remains functional to add more entries</p>"
    },
    @{
        title = "Verify Multiple Locations Displayed for a Single Email"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry has multiple locations already saved</p>"
        custom_steps = "<p>Navigate to the email notification settings screen<br />Locate the email entry with multiple locations<br />Observe how multiple locations are displayed</p>"
        custom_expected = "<p>All assigned locations are visible for that email entry<br />Locations are displayed clearly (chips, tags, or list format)<br />Each location has a delete/remove option<br />No locations are truncated or hidden</p>"
    },
    @{
        title = "Verify Delete Location Icon/Button is Present"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry has at least one location assigned</p>"
        custom_steps = "<p>Locate an email entry with assigned locations<br />Observe the delete/remove action next to each location</p>"
        custom_expected = "<p>Each assigned location has a visible delete/remove icon or button<br />The delete action is clearly associated with the specific location<br />Hovering or focusing on the delete action provides a visual cue</p>"
    },
    @{
        title = "Verify Cancel Button While Adding Location"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />Attach Location toggle is enabled for an email entry</p>"
        custom_steps = "<p>Begin adding a location by opening the dropdown<br />Select or search for a location<br />Click Cancel instead of saving</p>"
        custom_expected = "<p>Cancel button is visible during the add/edit process<br />Clicking Cancel discards any unsaved location changes<br />The email entry reverts to its previous state<br />No API call is made to save</p>"
    },
    # --- FUNCTIONAL TEST CASES ---
    @{
        title = "Add a Single Location to an Email - Happy Path"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />At least one email is configured for notifications</p>"
        custom_steps = "<p>Locate an email entry<br />Enable the Attach Location toggle for that email<br />Click the location dropdown<br />Search for a valid location<br />Select the location from the dropdown<br />Click Save</p>"
        custom_expected = "<p>The location is added and displayed under the email entry<br />A success confirmation is displayed<br />The saved location persists when the page is refreshed</p>"
    },
    @{
        title = "Add Multiple Locations to a Single Email"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />An email entry exists with Attach Location toggle enabled</p>"
        custom_steps = "<p>Click the location dropdown<br />Search and select a first location<br />Click the location dropdown again<br />Search and select a second location<br />Click the location dropdown again<br />Search and select a third location<br />Click Save</p>"
        custom_expected = "<p>All three locations are added and displayed under the email entry<br />Each location is individually visible and removable<br />A success confirmation is displayed<br />All locations persist after page refresh</p>"
    },
    @{
        title = "Delete a Location from an Email"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry has at least one location assigned</p>"
        custom_steps = "<p>Locate the email entry with assigned locations<br />Click the delete/remove action on a specific location<br />Confirm the deletion if prompted<br />Click Save</p>"
        custom_expected = "<p>The selected location is removed from the email entry<br />Other locations for the same email remain unchanged<br />The deletion persists after page refresh<br />Backend API reflects the updated state</p>"
    },
    @{
        title = "Enable Attach Location Toggle and Attempt to Save Empty Location"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />An email entry exists</p>"
        custom_steps = "<p>Enable the Attach Location toggle for an email entry<br />Do not select any location from the dropdown<br />Click Save</p>"
        custom_expected = "<p>Save is blocked or a validation error is displayed<br />Error message indicates that a location must be selected when the toggle is enabled<br />No empty location is saved to the backend</p>"
    },
    @{
        title = "Attempt to Add a Location Not in Backend Listing"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />Attach Location toggle is enabled for an email</p>"
        custom_steps = "<p>Click the location dropdown<br />Type a location name that does not exist in the backend listing<br />Observe the dropdown results<br />Attempt to submit or select the non-existent location</p>"
        custom_expected = "<p>The dropdown shows no matching results or displays a 'No results found' message<br />The user cannot select or add a location that is not in the backend listing<br />Free-text entry of locations is not allowed<br />No invalid location is saved</p>"
    },
    @{
        title = "Verify Saved State Persists After Page Reload"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User has previously saved an email with locations</p>"
        custom_steps = "<p>Navigate to the email notification settings screen<br />Verify the saved email and its locations are displayed<br />Refresh the browser page<br />Verify the email and locations are still displayed correctly<br />Navigate away from the page and return<br />Verify the state is still intact</p>"
        custom_expected = "<p>Saved email and locations are displayed correctly on initial load<br />Data persists after browser refresh<br />Data persists after navigating away and returning<br />State matches what was previously saved</p>"
    },
    @{
        title = "Verify Backend API Call After Saving Email with Location"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Browser developer tools (Network tab) are open<br />User is on the email notification settings screen</p>"
        custom_steps = "<p>Add a location to an email entry<br />Click Save<br />Observe the network request in developer tools<br />Check the API request payload<br />Check the API response</p>"
        custom_expected = "<p>An API call is made on save<br />The request payload contains the email address and the associated location(s)<br />The API response confirms successful save<br />The response data matches the submitted email and location configuration</p>"
    },
    @{
        title = "Cancel Adding Location - No Changes Saved"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry exists with no locations assigned<br />Attach Location toggle is enabled</p>"
        custom_steps = "<p>Click the location dropdown<br />Select a location from the dropdown<br />Click Cancel instead of Save<br />Observe the email entry state<br />Refresh the page</p>"
        custom_expected = "<p>The selected location is discarded<br />The email entry shows no locations after cancel<br />No API call is made to save the location<br />After page refresh, no location is associated with that email</p>"
    },
    @{
        title = "Search Location Dropdown with Partial Text"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Attach Location toggle is enabled for an email entry<br />Multiple locations exist in the backend</p>"
        custom_steps = "<p>Click the location dropdown<br />Type the first 3 characters of a known location name<br />Observe the filtered results<br />Select the desired location from the filtered list</p>"
        custom_expected = "<p>The dropdown filters results to show only locations matching the partial text<br />The correct location appears in the filtered results<br />Selecting the location adds it to the email entry<br />The search is case-insensitive</p>"
    },
    @{
        title = "Add Another Email and Attach Location to New Entry"
        custom_preconds = "<p>User is logged in as a Super Admin<br />User is on the email notification settings screen<br />At least one email already exists</p>"
        custom_steps = "<p>Click the 'Add Another Email' button<br />Enter a valid email address in the new entry<br />Enable the Attach Location toggle for the new email<br />Search and select a location from the dropdown<br />Click Save</p>"
        custom_expected = "<p>A new email entry is added successfully<br />The Attach Location toggle enables the location field<br />The selected location is associated with the new email<br />Both the email and location persist after page refresh</p>"
    },
    @{
        title = "Delete All Locations from an Email and Save"
        custom_preconds = "<p>User is logged in as a Super Admin<br />An email entry has multiple locations assigned</p>"
        custom_steps = "<p>Remove all locations from the email entry by clicking delete on each one<br />Click Save<br />Refresh the page</p>"
        custom_expected = "<p>All locations are removed from the email entry<br />Save is successful<br />After refresh, the email entry shows no locations<br />The Attach Location toggle state is updated accordingly</p>"
    },
    @{
        title = "Verify Location Dropdown Only Shows Backend Locations"
        custom_preconds = "<p>User is logged in as a Super Admin<br />Attach Location toggle is enabled for an email entry<br />Known list of valid locations exists in the backend</p>"
        custom_steps = "<p>Click the location dropdown<br />Scroll through all available options<br />Compare the dropdown options with the known backend location list</p>"
        custom_expected = "<p>The dropdown only displays locations that exist in the backend<br />No extra or invalid locations are shown<br />The list is complete and matches the backend data<br />Locations are displayed in a logical order (alphabetical or grouped)</p>"
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
