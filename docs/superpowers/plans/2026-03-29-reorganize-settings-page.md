# Reorganize Settings Page Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the monolithic `SettingsPage` into a modular hub-and-spoke architecture with dedicated sub-pages for better organization and maintainability.

**Architecture:** Hub-and-spoke model where a central `SettingsHubPage` navigates to specialized sub-pages (Server, Playback, Appearance, Interface, Support) using `GoRouter`.

**Tech Stack:** Flutter, Riverpod, GoRouter, SharedPreferences.

---

### Task 1: Scaffold and Routing

**Files:**
- Create: `lib/features/setup/presentation/pages/settings/settings_hub_page.dart`
- Create: `lib/features/setup/presentation/pages/settings/server_settings_page.dart`
- Create: `lib/features/setup/presentation/pages/settings/playback_settings_page.dart`
- Create: `lib/features/setup/presentation/pages/settings/appearance_settings_page.dart`
- Create: `lib/features/setup/presentation/pages/settings/interface_settings_page.dart`
- Create: `lib/features/setup/presentation/pages/settings/support_settings_page.dart`
- Modify: `lib/features/navigation/presentation/router.dart`

- [ ] **Step 1: Create placeholder sub-page widgets**
Create basic `ConsumerWidget` or `ConsumerStatefulWidget` placeholders in the new directory.

- [ ] **Step 2: Register routes in `router.dart`**
Add sub-routes under the `/settings` path.
```dart
GoRoute(
  path: '/settings',
  builder: (context, state) => const SettingsHubPage(),
  routes: [
    GoRoute(path: 'server', builder: (context, state) => const ServerSettingsPage()),
    GoRoute(path: 'playback', builder: (context, state) => const PlaybackSettingsPage()),
    GoRoute(path: 'appearance', builder: (context, state) => const AppearanceSettingsPage()),
    GoRoute(path: 'interface', builder: (context, state) => const InterfaceSettingsPage()),
    GoRoute(path: 'support', builder: (context, state) => const SupportSettingsPage()),
    GoRoute(path: 'logs', builder: (context, state) => const DebugLogViewerPage()),
  ],
)
```

- [ ] **Step 3: Update unconfigured redirect (Optional/Check)**
Ensure `router.dart` still redirects to `/settings` (or now specifically `/settings/server`) if the server is not configured.

- [ ] **Step 4: Commit initial scaffold**
```bash
git add lib/features/setup/presentation/pages/settings/ lib/features/navigation/presentation/router.dart
git commit -m "feat(settings): scaffold hub-and-spoke structure and routes"
```

---

### Task 2: Implement Settings Hub Page

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/settings_hub_page.dart`

- [ ] **Step 1: Build the Hub UI**
Use a `Scaffold` with an `AppBar` and a `ListView`. Add `ListTile`s for:
- **Server:** `Icons.dns`, "Connection and API configuration"
- **Playback:** `Icons.play_circle`, "Player behavior and interactions"
- **Appearance:** `Icons.palette`, "Theme and colors"
- **Interface:** `Icons.dashboard`, "Navigation and layout defaults"
- **Support:** `Icons.help_outline`, "Diagnostics and about"

- [ ] **Step 2: Connect Navigation**
Use `context.push('/settings/server')`, etc.

- [ ] **Step 3: Commit Hub Page**
```bash
git add lib/features/setup/presentation/pages/settings/settings_hub_page.dart
git commit -m "feat(settings): implement settings hub page"
```

---

### Task 3: Implement Server Settings Page

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/server_settings_page.dart`
- Reference: `lib/features/setup/presentation/settings_page.dart`

- [ ] **Step 1: Extract and move server logic**
Move `_baseUrlController`, `_apiKeyController`, `_saveServerSettings`, `_canConnect`, and `_flushRuntimeCachesAfterServerChange` logic. 

- [ ] **Step 2: Refine save triggers**
Ensure settings are saved primarily on **focus loss** (via `FocusNode` listener) and **explicit button press**, as per the design spec to reduce unnecessary triggers. Remove `onSubmitted` triggers if they conflict.

- [ ] **Step 3: Build Server UI**
Include:
- `_buildConnectionStatusCard()`
- Server URL and API Key TextFields.
- "Test Connection" and "Clear Settings" buttons.

- [ ] **Step 4: Commit Server Settings**
```bash
git add lib/features/setup/presentation/pages/settings/server_settings_page.dart
git commit -m "feat(settings): migrate server settings to dedicated page"
```

---

### Task 4: Implement Playback Settings Page

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/playback_settings_page.dart`

- [ ] **Step 1: Implement Playback UI**
Include `SwitchListTile.adaptive` for:
- Prefer sceneStreams
- Autoplay Next
- Background Playback
- Native PiP
- Show Video Debug Info
And the `LayoutBuilder` with `SegmentedButton` for **Seek Interaction**.

- [ ] **Step 2: Connect persistence logic**
Ensure `_saveToggleSettings` behavior is preserved.

- [ ] **Step 3: Commit Playback Settings**
```bash
git add lib/features/setup/presentation/pages/settings/playback_settings_page.dart
git commit -m "feat(settings): migrate playback settings to dedicated page"
```

---

### Task 5: Implement Appearance and Interface Pages

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/appearance_settings_page.dart`
- Modify: `lib/features/setup/presentation/pages/settings/interface_settings_page.dart`

- [ ] **Step 1: Implement Appearance UI**
Include `_buildColorSelector()` and the `ThemeMode` `SegmentedButton`.

- [ ] **Step 2: Implement Interface UI**
Include "Show Random Navigation Buttons", "Show Edit Button (WIP)", and the "Scenes Layout" `DropdownMenu`.

- [ ] **Step 3: Commit both pages**
```bash
git add lib/features/setup/presentation/pages/settings/appearance_settings_page.dart lib/features/setup/presentation/pages/settings/interface_settings_page.dart
git commit -m "feat(settings): migrate appearance and interface settings"
```

---

### Task 6: Implement Support Page and Cleanup

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/support_settings_page.dart`
- Delete or Repurpose: `lib/features/setup/presentation/settings_page.dart`

- [ ] **Step 1: Implement Support UI**
Include "Debug Log Viewer" `ListTile` (linking to `/settings/logs`) and "GitHub Repository" `ListTile`.

- [ ] **Step 2: Final Verification**
Run the app, navigate to each sub-page, change settings, and verify they persist. Ensure "Back" buttons return to the Hub.

- [ ] **Step 3: Repurpose old SettingsPage**
Either delete `lib/features/setup/presentation/settings_page.dart` (if no longer needed by router) or have it just export `SettingsHubPage`. Prefer deleting if `router.dart` is updated correctly.

- [ ] **Step 4: Commit final cleanup**
```bash
git add .
git commit -m "feat(settings): final cleanup and migration complete"
```

