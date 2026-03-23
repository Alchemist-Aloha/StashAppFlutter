# Color Scheme Selector Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a color scheme selector to the settings page with presets and custom hex input following Material 3 style.

**Architecture:** 
- Use a `NotifierProvider` to manage and persist the seed color.
- Refactor `AppTheme` to dynamically build themes based on the provider's state.
- Update `SettingsPage` with a horizontal swatch strip and conditional hex input.

**Tech Stack:** Flutter, Riverpod, SharedPreferences.

---

### Task 1: Create Theme Color Provider

**Files:**
- Create: `lib/core/presentation/theme/theme_color_provider.dart`

- [ ] **Step 1: Write the provider implementation**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/preferences/shared_preferences_provider.dart';

const appThemeSeedColorPreferenceKey = 'app_theme_seed_color';
const defaultSeedColor = Color(0xFF0F766E);

class AppThemeColorNotifier extends Notifier<Color> {
  @override
  Color build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final colorValue = prefs.getInt(appThemeSeedColorPreferenceKey);
    return colorValue != null ? Color(colorValue) : defaultSeedColor;
  }

  Future<void> setThemeColor(Color color) async {
    if (state == color) return;
    state = color;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(appThemeSeedColorPreferenceKey, color.value);
  }
}

final appThemeColorProvider = NotifierProvider<AppThemeColorNotifier, Color>(
  AppThemeColorNotifier.new,
);
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/theme/theme_color_provider.dart
git commit -m "feat: add appThemeColorProvider for dynamic seed color"
```

---

### Task 2: Refactor AppTheme for Dynamic Seed Color

**Files:**
- Modify: `lib/core/presentation/theme/app_theme.dart`

- [ ] **Step 1: Update `AppTheme` to accept seed color**

Refactor `_buildTheme` and the static getters.

```dart
// Change _buildTheme signature
static ThemeData buildTheme(Brightness brightness, Color seedColor) {
  final isDark = brightness == Brightness.dark;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );
  // ... rest of the method remains same using colorScheme
}

// Remove static lightTheme and darkTheme
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/theme/app_theme.dart
git commit -m "refactor: make AppTheme.buildTheme dynamic"
```

---

### Task 3: Update MyApp to use Dynamic Theme

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Watch `appThemeColorProvider` in `MyApp`**

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final seedColor = ref.watch(appThemeColorProvider); // Add this
    
    return MaterialApp.router(
      routerConfig: router,
      title: 'StashFlow',
      themeMode: themeMode,
      theme: AppTheme.buildTheme(Brightness.light, seedColor), // Update this
      darkTheme: AppTheme.buildTheme(Brightness.dark, seedColor), // Update this
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/main.dart
git commit -m "feat: integrate appThemeColorProvider into MyApp"
```

---

### Task 4: Update SettingsPage with Color Selector

**Files:**
- Modify: `lib/features/setup/presentation/settings_page.dart`

- [ ] **Step 1: Add state for color selection**

Add `_seedColor` and `_customHexController` to `_SettingsPageState`.

- [ ] **Step 2: Implement Color Swatch Widget and Hex Input**

Add helper methods to build the UI components in `SettingsPage`.

- [ ] **Step 3: Update `_load` and `_saveThemeMode` equivalents**

Ensure the UI stays in sync with the provider.

- [ ] **Step 4: Commit**

```bash
git add lib/features/setup/presentation/settings_page.dart
git commit -m "feat: add color scheme selector to settings page"
```

---

### Task 5: Verification

- [ ] **Step 1: Run the app and test color presets**
- [ ] **Step 2: Test custom hex input (e.g., #FF00FF)**
- [ ] **Step 3: Verify persistence after restart**
- [ ] **Step 4: Verify Light/Dark mode transitions with different seed colors**
