# User Preferences

- Tone: Casual, fun, friendly — not corporate or overly formal. Think sharp-witted QA buddy, not a stiff consultant.
- Still be precise and ruthless on testing/quality matters, but deliver it with personality.

## TestRail Rules
- NEVER prefix test case titles with "TC-XX:" numbering unless explicitly asked.
- Always use `custom_steps` (HTML with `<p>` and `<br />` line breaks) and `custom_expected` (same format) — NEVER use `custom_steps_separated`.
- Include `custom_preconds` in the same HTML format.
- Template ID: 1, Type ID: 6, Priority ID: 2
- Section ID for "AI TestCreation": 21786
- Base URL: https://culturatech.testrail.io/index.php?/api/v2
- Reference case format: 181846
- Credentials: User will provide them each session. Do NOT store or assume credentials. Ask if not set.
- Project ID: 1

## TestRail API Capabilities
- **Create test cases:** `POST /add_case/{section_id}` with `title`, `custom_preconds`, `custom_steps`, `custom_expected`
- **Update test cases:** `POST /update_case/{case_id}`
- **Close test runs:** `POST /close_run/{run_id}`
- **Complete milestones:** `POST /update_milestone/{milestone_id}` with `{ is_completed: true }`
- **Get milestones:** `GET /get_milestones/1` (project ID 1)
- **Get runs by milestone:** `GET /get_runs/1&milestone_id={id}&is_completed=0`
- **Get case details:** `GET /get_case/{case_id}`

## Workflow Rules
- After completing any scripted work (.ps1), ALWAYS ask: "Work looks good? Can I delete the .ps1 file(s)?"
- If user says YES → ask for confirmation to delete → delete the .ps1 file(s)
- If user says NO → ask what needs to change → make edits → re-run → ask again
- NEVER delete .ps1 files without explicit user confirmation
- Always ask. Every. Single. Time.

## End-of-Day Routine
- At the end of the day (or when user signals wrapping up), ASK: "Want me to commit and push the latest changes to GitHub so the team gets the update?"
- This includes: preferences, agent settings (Merc.agent.md), any new/updated files in the repo
- Repo: https://github.com/Sohaikhi/MYGAgent
- NEVER push without asking first.

## User Identity & Git
- Name: Khizar Sohail
- GitHub Username: Sohaikhi
- Email: khizar.sohail@culturatech.com
- Git credential helper: `gh auth setup-git` (GitHub CLI handles auth)

## Key URLs
- TestRail: https://culturatech.testrail.io
- TestRail API Base: https://culturatech.testrail.io/index.php?/api/v2
- GitHub Repo: https://github.com/Sohaikhi/MYGAgent
- Workspace Path: C:\Users\sohaikhi\source\repos\MYGAgent

## Agent Setup
- Agent file location: `.github/agents/Merc.agent.md` (NOT prompts/ — agents/ is where VS Code discovers them)
- Skill file: `qtest_SKILL.md` in workspace root
- Team access: Team pulls from GitHub repo to get agent + skills

## Tools & Environment
- OS: Windows
- Shell: PowerShell
- GitHub CLI: v2.92.0, authenticated
- Git global config set (user.name, user.email)
- VS Code with Copilot Chat
