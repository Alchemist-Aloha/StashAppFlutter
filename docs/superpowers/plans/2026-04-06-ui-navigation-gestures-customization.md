# UI, Navigation, and Gesture Customization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement "True Black" AMOLED theme, customizable navigation tabs (reorder/hide), and "Shake to Random" discovery gesture.

**Architecture:** 
- Use Riverpod `Notifier` for persisting customization states in `SharedPreferences`.
- Extend `AppTheme` to reactively update based on the `TrueBlack` provider.
- Decouple `ShellPage` navigation destinations from hardcoded lists to a dynamic provider-driven list.
- Integrate `shake_gesture` in the root `ShellPage` to globally handle discovery triggers.

**Tech Stack:** Flutter, Riverpod, SharedPreferences, shake_gesture.

---

### Task 1: Add `shake_gesture` dependency

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Add the package**
Add `shake_gesture: ^2.1.0` to `dependencies`.

- [ ] **Step 2: Run pub get**
Run: `dart pub get`

- [ ] **Step 3: Commit**
```bash
git add pubspec.yaml
git commit -m "feat: add shake_gesture dependency"
```

### Task 2: Implement "True Black" (AMOLED) Mode

**Files:**
- Create: `lib/core/presentation/theme/true_black_provider.dart`
- Modify: `lib/core/presentation/theme/app_theme.dart`
- Modify: `lib/features/setup/presentation/pages/settings/appearance_settings_page.dart`
- Test: `test/core/theme_test.dart`

- [ ] **Step 1: Create TrueBlack provider**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/preferences/shared_preferences_provider.dart';

class TrueBlackNotifier extends Notifier<bool> {
  static const _key = 'use_true_black';
  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> set(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(_key, value);
  }
}

final trueBlackEnabledProvider = NotifierProvider<TrueBlackNotifier, bool>(TrueBlackNotifier.new);
```

- [ ] **Step 2: Update AppTheme.buildTheme**
Modify `buildTheme` signature and implementation to use pure black if `useTrueBlack` is enabled.
```dart
static ThemeData buildTheme(Brightness brightness, Color seedColor, {bool useTrueBlack = false}) {
  final isDark = brightness == Brightness.dark;
  // ... existing colorScheme generation
  if (isDark && useTrueBlack) {
    colorScheme = colorScheme.copyWith(
      surface: Colors.black,
      surfaceContainer: Colors.black,
      surfaceContainerHigh: Colors.black,
      surfaceContainerHighest: Colors.black,
      // ... ensure contrast
    );
  }
  // ... rest of theme config
}
```

- [ ] **Step 3: Update AppearanceSettingsPage**
Add `SwitchListTile` for "True Black" mode.

- [ ] **Step 4: Commit**
```bash
git add lib/core/presentation/theme/ lib/features/setup/presentation/pages/settings/appearance_settings_page.dart
git commit -m "feat: implement True Black mode"
```

### Task 3: Implement Navigation Tab Customization

**Files:**
- Create: `lib/features/setup/presentation/providers/navigation_tabs_provider.dart`
- Create: `lib/features/setup/presentation/pages/settings/navigation_customization_page.dart`
- Modify: `lib/features/navigation/presentation/shell_page.dart`
- Modify: `lib/features/setup/presentation/pages/settings/interface_settings_page.dart`

- [ ] **Step 1: Create NavigationTabsProvider**
Define `NavigationTab` enum and a notifier that stores the ordered list of enabled tabs.

- [ ] **Step 2: Update ShellPage to be dynamic**
Instead of hardcoded `navigationDestinations`, watch `navigationTabsProvider` and build the list dynamically.
Map UI index -> Branch index.

- [ ] **Step 3: Create Customization UI**
Implement `NavigationCustomizationPage` with a `ReorderableListView` and `Switch` for each tab.

- [ ] **Step 4: Commit**
```bash
git add lib/features/setup/presentation/providers/navigation_tabs_provider.dart lib/features/setup/presentation/pages/settings/navigation_customization_page.dart lib/features/navigation/presentation/shell_page.dart
git commit -m "feat: add customizable navigation tabs"
```

### Task 4: Implement "Shake to Random"

**Files:**
- Modify: `lib/features/navigation/presentation/shell_page.dart`
- Modify: `lib/features/setup/presentation/pages/settings/interface_settings_page.dart`
- Create: `lib/features/setup/presentation/providers/gesture_settings_provider.dart`

- [ ] **Step 1: Create GestureSettingsProvider**
Toggle for `shakeToRandomEnabled`.

- [ ] **Step 2: Wrap ShellPage in ShakeGesture**
```dart
ShakeGesture(
  onShake: () {
    if (!ref.read(shakeToRandomEnabledProvider)) return;
    final index = navigationShell.currentIndex;
    // Map index to action: e.g., if index 0 (Scenes), call scene random provider
  },
  child: Scaffold(...)
)
```

- [ ] **Step 3: Add settings toggle**
Add "Shake to Discover" to `InterfaceSettingsPage`.

- [ ] **Step 4: Commit**
```bash
git add lib/features/setup/presentation/providers/gesture_settings_provider.dart lib/features/navigation/presentation/shell_page.dart lib/features/setup/presentation/pages/settings/interface_settings_page.dart
git commit -m "feat: implement Shake to Random gesture"
```

### Task 5: Verification

- [ ] **Step 1: Run Static Analysis**
Run: `dart analyze`

- [ ] **Step 2: Run Theme Tests**
Verify AMOLED black is applied correctly in `ThemeData`.

- [ ] **Step 3: Manual Verification**
Verify tab reordering reflects immediately in the `NavigationBar`.
Verify "True Black" changes background to `#000000`.
