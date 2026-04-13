# Spec: UI, Navigation, and Gesture Customization

Enhance StashFlow's personalization by allowing users to tune the visual depth, choose their navigation layout, and discover content via physical gestures.

## 1. UI & Theming: "True Black" (AMOLED)

### Problem
Default dark themes often use dark grey surfaces (`#121212`). On OLED/AMOLED screens, pure black (`#000000`) saves more battery and provides infinite contrast.

### Solution
Add a "True Black" toggle that overrides the standard Material 3 dark surface colors.

### Implementation Details
- **Provider**: Create `TrueBlackEnabledProvider` in `lib/core/presentation/theme/true_black_provider.dart` using `Notifier` and `SharedPreferences`.
- **Theme Logic**: 
  - Update `AppTheme.buildTheme` (in `lib/core/presentation/theme/app_theme.dart`) to accept a `bool useTrueBlack`.
  - When `useTrueBlack` is true and `brightness` is `dark`:
    - Set `scaffoldBackgroundColor` to `Colors.black`.
    - Set `colorScheme.surface` and `colorScheme.surfaceContainer` variants to `Colors.black`.
    - Ensure `colorScheme.onSurface` and `colorScheme.outline` maintain readable contrast.
- **UI**: Add a `SwitchListTile` to `AppearanceSettingsPage` under a new "Advanced Theming" section.

## 2. Navigation: Customizable Tabs

### Problem
Not all users use all 5 tabs (Scenes, Performers, Studios, Tags, Galleries). Some might want to hide "Galleries" or move "Performers" to the first position.

### Solution
A dynamic navigation system where the order and visibility of the `NavigationBar`/`NavigationRail` destinations are stored in user preferences.

### Implementation Details
- **Data Model**: Define a `NavigationTab` enum or class with `id`, `label`, `icon`, and `defaultOrder`.
- **Provider**: Create `NavigationTabsProvider` in `lib/features/setup/presentation/providers/navigation_tabs_provider.dart`.
  - State: `List<NavigationTab>` representing the enabled tabs in their desired order.
  - Persist as a JSON string or comma-separated list of IDs in `SharedPreferences`.
- **ShellPage Integration**:
  - `ShellPage` (in `lib/features/navigation/presentation/shell_page.dart`) will watch `navigationTabsProvider`.
  - It will map the stored IDs to the actual `GoRouter` branch indices.
  - **Constraint**: Since `StatefulNavigationShell` indices are fixed by the router configuration, the `ShellPage` must map the "UI Index" (0, 1, 2...) to the "Branch Index" defined in `router.dart`.
- **UI**: Add a "Customize Navigation" sub-page or section in `InterfaceSettingsPage` allowing users to toggle visibility and drag-to-reorder tabs (using `ReorderableListView`).

## 3. Gestures: Shake to Random

### Problem
Users often want "serendipitous" discovery without looking for a specific button. 

### Solution
Implement a "Shake to Random" gesture that triggers the "Random" discovery action for the currently active tab.

### Implementation Details
- **Dependency**: Add `shake_gesture` to `pubspec.yaml`.
- **ShellPage Integration**:
  - Wrap the `Scaffold` or main `body` in `ShellPage` with a `ShakeGesture` widget.
  - **Logic**: On shake, check the `navigationShell.currentIndex`.
    - Map the index to the corresponding feature (Scenes -> jump to random scene, Performers -> jump to random performer, etc.).
    - Call the relevant `jumpToRandom()` method on the feature's list provider.
- **UI**: Add a "Shake to Discover" toggle in `InterfaceSettingsPage` under a "Gestures" section.

## 4. Testing Strategy
- **Unit Tests**: Verify `NavigationTabsProvider` correctly handles reordering and visibility toggles.
- **Widget Tests**: 
  - Verify `AppTheme` produces pure black colors when "True Black" is enabled.
  - Verify `ShellPage` renders the correct number of destinations based on visibility settings.
- **Integration Tests**: Simulate a shake gesture and verify that the page navigates to a random item.
