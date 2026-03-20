# Scene Scraping Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the ability for users to scrape metadata for a single scene using available Stash scrapers, review the scraped data, modify it if necessary, and save it back to the server.

**Architecture:** 
1.  **Data Layer:** Extend `GraphQLSceneRepository` to include `listScrapers`, `scrapeSingleScene`, and `sceneUpdate` operations. Update the domain entities and GraphQL queries.
2.  **Domain/State Layer:** Create a new provider (`SceneScrapeProvider`) to manage the state of the scraping process (fetching scrapers, executing the scrape, holding the result).
3.  **Presentation Layer:** 
    *   Add a "Scrape" button/action in the `SceneDetailsPage` (or an edit page).
    *   Create a modal bottom sheet or dialog (`ScrapeSourceSelector`) to let the user select from available scrapers.
    *   Create a new page/view (`SceneScrapeEditView`) to display the scraped results alongside the current scene data, allowing the user to edit fields before saving.

**Tech Stack:** Flutter, Riverpod, GraphQL (graphql_codegen).

---

### Task 1: Update GraphQL Queries and Models

**Files:**
- Modify: `lib/features/scenes/data/graphql/scenes.graphql`
- Run: `build_runner`

- [ ] **Step 1: Add queries and mutations to `scenes.graphql`**

```graphql
# lib/features/scenes/data/graphql/scenes.graphql

query ListSceneScrapers {
  listScrapers(types: [SCENE]) {
    id
    name
    scene {
      supported_scrapes
    }
  }
}

query ScrapeSingleScene($source: ScraperSourceInput!, $input: ScrapeSingleSceneInput!) {
  scrapeSingleScene(source: $source, input: $input) {
    title
    code
    details
    director
    urls
    date
    image
    studio {
      stored_id
      name
    }
    tags {
      stored_id
      name
    }
    performers {
      stored_id
      name
    }
  }
}

mutation UpdateScene($input: SceneUpdateInput!) {
  sceneUpdate(input: $input) {
    id
    title
    details
    date
    director
    urls
    studio {
      id
      name
    }
    tags {
      id
      name
    }
    performers {
      id
      name
    }
  }
}
```

- [ ] **Step 2: Generate GraphQL code**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: SUCCESS

- [ ] **Step 3: Commit**

```bash
git add lib/features/scenes/data/graphql/scenes.graphql lib/core/data/graphql/__generated__/
git commit -m "feat(graphql): add scene scraping and update queries"
```

---

### Task 2: Extend Scene Repository

**Files:**
- Modify: `lib/features/scenes/domain/repositories/scene_repository.dart`
- Modify: `lib/features/scenes/data/repositories/graphql_scene_repository.dart`
- Create/Modify: Define domain models for `Scraper` and `ScrapedScene` if necessary, or map directly to existing entities or simplified DTOs.

- [ ] **Step 1: Update `SceneRepository` interface**

```dart
// lib/features/scenes/domain/repositories/scene_repository.dart
// Add these methods:
Future<List<Map<String, dynamic>>> getAvailableScrapers();
Future<Map<String, dynamic>?> scrapeScene(String sceneId, String scraperId);
Future<void> updateScene(String sceneId, Map<String, dynamic> updates);
```
*(Note: Using Map<String, dynamic> here for brevity in the plan, but strongly typed domain entities are preferred for the actual implementation).*

- [ ] **Step 2: Implement methods in `GraphQLSceneRepository`**

```dart
// lib/features/scenes/data/repositories/graphql_scene_repository.dart
// Implement getAvailableScrapers, scrapeScene, and updateScene using the newly generated GraphQL classes.
```

- [ ] **Step 3: Commit**

```bash
git add lib/features/scenes/domain/repositories/scene_repository.dart lib/features/scenes/data/repositories/graphql_scene_repository.dart
git commit -m "feat: implement scraping methods in scene repository"
```

---

### Task 3: Create Scrape State Provider

**Files:**
- Create: `lib/features/scenes/presentation/providers/scene_scrape_provider.dart`

- [ ] **Step 1: Create the provider**

```dart
// lib/features/scenes/presentation/providers/scene_scrape_provider.dart
// Create an AsyncNotifier that:
// 1. Fetches available scrapers.
// 2. Has a method to execute a scrape given a scraperId and sceneId.
// 3. Manages the state of the scraped data so the UI can edit it.
// 4. Has a method to save the finalized data via the repository.
```

- [ ] **Step 2: Generate provider code**

Run: `dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 3: Commit**

```bash
git add lib/features/scenes/presentation/providers/scene_scrape_provider.dart
git commit -m "feat: add scene scrape state provider"
```

---

### Task 4: UI - Scraper Selection and Edit View

**Files:**
- Modify: `lib/features/scenes/presentation/pages/scene_details_page.dart`
- Create: `lib/features/scenes/presentation/widgets/scrape_dialogs.dart` (or similar)

- [ ] **Step 1: Add Scrape Action to SceneDetailsPage**
Add an icon button (e.g., `Icons.download` or `Icons.auto_fix_high`) to the AppBar or a bottom action bar in `SceneDetailsPage`.

- [ ] **Step 2: Create Scraper Selection Dialog**
When the scrape button is pressed, show a bottom sheet listing the available scrapers fetched from the provider.

- [ ] **Step 3: Create Scraped Data Edit View**
Once a scrape returns data:
1. Show a dialog or navigate to a new page.
2. Present a form pre-filled with the scraped data (Title, Date, Details, Director).
3. Allow the user to edit these fields.
4. Provide a "Save" button that calls the provider's update method.

- [ ] **Step 4: Handle Entity Relationships (Crucial)**
For Studios, Performers, and Tags returned by the scrape:
*   The UI needs to show if they matched an existing entity (`stored_id` is present).
*   *Simplification for MVP:* If `stored_id` is missing, just ignore the entity or show it as text-only, as the `UpdateScene` mutation requires actual IDs. Do not attempt to auto-create entities in this first iteration.

- [ ] **Step 5: Commit**

```bash
git add lib/features/scenes/presentation/
git commit -m "feat: implement scene scraping UI and edit flow"
```

---

### Task 5: Verification

- [ ] **Step 1: Test the flow**
Run the app, navigate to a scene, trigger a scrape, select a scraper, verify data is returned, edit a text field, save, and verify the UI updates with the new data.

- [ ] **Step 2: Run static analysis and tests**
`flutter analyze`
`flutter test`