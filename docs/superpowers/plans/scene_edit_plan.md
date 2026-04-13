## Plan: Scene Details Edit Flow

TL;DR — Add an Edit UI on the Scene Details page (modal or full page), allow editing key fields (title, details, release date, URLs, cover), validate/normalize inputs, then save by reusing the existing `saveScrapedScene` / `sceneUpdate` pipeline and invalidate providers.

**Steps**
1. Confirm UX: modal dialog vs full page editor 
2. Add an editor widget: `SceneEditDialog` (or `SceneEditPage`) with form fields for `title`, `details`, `date`, `urls` (list), `cover image` and simple tag/performer text inputs.
3. Pre-fill form with current `Scene` values (map `Scene` -> `ScrapedScene`/`SceneUpdateInput`).
4. Validate & normalize inputs using current normalizer helpers (`buildSceneUpdateInputFromScraped` semantics). If useful, reuse `scrape_normalizer` functions or create a small adapter to construct `ScrapedScene`.
5. On save: call existing repository flow (`sceneRepository.saveScrapedScene` or `sceneScrapeProvider.saveScraped`) with the constructed `ScrapedScene`/`SceneUpdateInput`.
6. Show progress / error UI and on success: invalidate `sceneDetailsProvider(scene.id)` and `sceneListProvider`, close dialog, and show SnackBar confirmation.
7. Add basic widget tests and a manual verification checklist.

**Relevant files**
- lib/features/scenes/presentation/pages/scene_details_page.dart — add Edit button and show dialog/page.
- lib/features/scenes/presentation/widgets/scene_scrape_view.dart — reuse UI patterns for save flow and reconciliation.
- lib/features/scenes/presentation/widgets/scene_edit_dialog.dart — new file to implement (or page variant).
- lib/features/scenes/data/repositories/graphql_scene_repository.dart — existing `saveScrapedScene` / GraphQL mutations to call.
- lib/features/scenes/data/utils/scrape_normalizer.dart — normalization logic to match before saving.
- lib/features/scenes/domain/models/scraped_scene.dart — model to construct for save.

**Verification**
1. Run `flutter analyze` and `dart format .` to ensure no lint/format issues.
2. Unit/widget tests: add a widget test that taps Edit, changes title, saves, and asserts provider invalidation or SnackBar shown.
3. Manual test: open a scene, tap Edit, modify fields, save; verify mutation executed (network logs) and scene detail updates after provider invalidation.
4. Edge cases: try invalid URL/date and assert validation blocks save with user-facing errors.

**Decisions / Assumptions**
- Use modal dialog by default for minimal UX changes; full page if editing is complex or image picking required.
- Save will reuse the existing repository pipeline (`saveScrapedScene`) to keep reconciliation consistent.
- Image picking: assume app already has conventions for converting images to `cover_image` data URL (reuse normalizer). If not, add image->dataURL conversion helper.

**Further Considerations**
1. Choose UX: Modal (quick) / Full page (more space). Recommend Modal unless heavy image editing is required.
2. Reconciliation behavior: allow "create missing performers/tags" or prompt user — default to existing repository behavior.
3. Permissions/feature flag: only show Edit when user has permission; respect `scrapeEnabled` flag already used in UI.

**Confirmed UX**
- Modal dialog selected by user (quick, minimal changes).

**Implementation Checklist (Modal)**
1. Create `lib/features/scenes/presentation/widgets/scene_edit_dialog.dart` implementing `SceneEditDialog`:
   - Constructor: `SceneEditDialog({required Scene scene})` or take `sceneId` + provider lookup.
   - Form fields: `title` (TextField), `details` (multiline TextField), `release_date` (TextField with date picker), `urls` (comma-separated TextField or dynamic list), `cover` (optional image picker/button).
   - Buttons: `Cancel`, `Save`.
2. Pre-fill fields from provided `Scene` instance and map to `ScrapedScene` when saving.
3. Validation: ensure date is YYYY-MM-DD or use date picker; validate URLs using existing `isValidUrl` helper if present (or simple RegExp).
4. On Save:
   - Build a `ScrapedScene` instance or `SceneUpdateInput` map following `buildSceneUpdateInputFromScraped` expectations.
   - Call `ref.read(sceneScrapeProvider.notifier).saveScraped(sceneId, scrapedScene)` or `ref.read(sceneRepositoryProvider).saveScrapedScene(...)` depending on available API.
   - Show loading indicator, handle errors, and show SnackBar on success.
5. On success: `ref.invalidate(sceneDetailsProvider(scene.id))` and `ref.invalidate(sceneListProvider)` and close dialog.
6. Wire up `scene_details_page.dart`: add an `Edit` `FilledButton.tonalIcon` alongside Scrape button that opens the modal via `showDialog` or `showModalBottomSheet`.
7. Add a widget test that opens the dialog, edits title, taps Save, and expects provider to be invalidated (or SnackBar shown).
8. Run `flutter analyze`, `dart format .`, and `flutter test` for the new tests.

**Notes**
- Reuse existing provider `sceneScrapeProvider` behavior for saving to keep reconciliation consistent.
- If image picking is required, prefer reusing existing app image picker helpers; otherwise, leave as URL-only for a first pass.

Implementation ready — apply the patch files when ready.
