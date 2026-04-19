## Stage
- team-exec

## Goal / Non-goals
### Goals
- Improve UX/UI for `AuthMode` selection in `ServerSettingsPage`.
- Replace `SegmentedButton` with `DropdownButtonFormField`.
- Ensure consistent styling with other form fields.

### Non-goals
- Changing any underlying auth logic or providers.

## Task Graph
| Task ID | Priority | Task | Owner | Dependency | Path Type | Worktree | Baseline | Lane Notes | Validation |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R1 | p1 | Replace `SegmentedButton` with `DropdownButtonFormField` | omg-executor | - | critical | - | HEAD | - | Check UI layout |
| R2 | p1 | Align `DropdownButtonFormField` decoration with existing fields | omg-executor | R1 | sequential | - | HEAD | - | Visual check |
| R3 | p1 | Verify selection logic and settings persistence | omg-executor | R1 | sequential | - | HEAD | - | Manual testing |

## Critical Files
- `lib/features/setup/presentation/pages/settings/server_settings_page.dart`

## Taskboard Sync
- Initialization complete.

## Ready For team-prd
- Yes.
