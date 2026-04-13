# Design Spec: Reorganize Settings Page (Hub-and-Spoke Architecture)

**Date:** 2026-03-29
**Status:** Draft
**Topic:** UI/UX & Architectural Refactoring of Settings

## 1. Problem Statement
The current `SettingsPage` is a large, monolithic file (`lib/features/setup/presentation/settings_page.dart`) that manages:
- Server configuration and connection testing.
- Playback behavior (autoplay, PiP, seeking).
- Navigation and layout preferences.
- Appearance (theme mode, seed colors).
- Diagnostics and links.

This approach causes high cognitive load for users and makes the code difficult to maintain or extend. As more settings are added, the single scrolling list becomes unmanageable.

## 2. Proposed Solution
Transform the settings experience from a single long list into a **modular hub-and-spoke architecture**.

### 2.1 UI/UX Changes
- **Settings Hub:** A central menu with high-level categories (Server, Playback, Appearance, Interface, Support).
- **Sub-pages:** Dedicated screens for each category, allowing for focused configuration and better labeling.
- **Deep Linking:** Each section will have its own URL/route (e.g., `/settings/playback`).

### 2.2 Architectural Changes
- **Componentization:** Refactor the monolith into smaller, focused widgets/pages.
- **State Management:** Keep logic close to where it's used. For example, `TextEditingControllers` for server settings will live only in the `ServerSettingsPage`.
- **Navigation:** Update `GoRouter` to support nested settings routes.

## 3. Detailed Design

### 3.1 Folder Structure
New directory: `lib/features/setup/presentation/pages/settings/`
- `settings_hub_page.dart`: The main menu.
- `server_settings_page.dart`: Connection status, URL, API Key.
- `playback_settings_page.dart`: Streams, Autoplay, PiP, Seek behavior.
- `appearance_settings_page.dart`: Theme mode, Seed color selection.
- `interface_settings_page.dart`: Navigation (Random Buttons, Edit Button WIP) and Display Layouts (List/Grid/TikTok).
- `support_settings_page.dart`: Debug logs and "About" (GitHub link, version info).

### 3.2 State & Data Flow
- **Persisted State:** Continue using `sharedPreferencesProvider` and specialized providers (e.g., `appThemeModeProvider`) for persistence.
- **Local Buffer:** `ServerSettingsPage` will use `TextEditingController` for input, saving to preferences only on focus loss or explicit "Test Connection" button press.

### 3.3 Routing (GoRouter)
Update `lib/features/navigation/presentation/router.dart`:
- `/settings` (Redirects to or builds `SettingsHubPage`)
- `/settings/server`
- `/settings/playback`
- `/settings/appearance`
- `/settings/interface`
- `/settings/support`

## 4. Implementation Plan (High-Level)
1. **Scaffold:** Create the new directory and empty page files.
2. **Routing:** Add sub-routes to `router.dart`.
3. **Refactor:** Move UI code and logic from the old `SettingsPage` to the respective sub-pages.
4. **Hub Page:** Implement the `SettingsHubPage` with `ListTile` navigation.
5. **Clean up:** Delete or repurpose the old monolithic file.

## 5. Verification Plan
- **Manual UI Test:** Navigate through all sub-pages and ensure "Back" buttons work as expected.
- **Functional Test:** Verify that changing a setting in a sub-page (e.g., Theme Mode) immediately updates the app and persists after restart.
- **Connection Test:** Ensure the "Test Connection" logic still works correctly in its new home.
- **Regression Test:** Check that deep links to `/settings/logs` still function.
