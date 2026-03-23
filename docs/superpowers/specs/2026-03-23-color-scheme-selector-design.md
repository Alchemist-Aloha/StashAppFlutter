# Design Spec: Color Scheme Selector

**Date:** 2026-03-23
**Status:** Approved
**Topic:** Material 3 Color Scheme Selector in Settings

## 1. Objective
Add a color scheme selector to the StashFlow settings page, allowing users to choose from a set of preset Material 3 seed colors or provide a custom Hex value. The application theme should dynamically update based on the selected seed color.

## 2. Architecture & State Management

### 2.1. Theme Color Provider
A new provider will be created to manage the application's seed color.

- **File:** `lib/core/presentation/theme/theme_color_provider.dart`
- **Provider:** `appThemeColorProvider` (a `NotifierProvider<AppThemeColorNotifier, Color>`)
- **State:** The current `Color` used as the seed for `ColorScheme.fromSeed`.
- **Default Value:** `0xFF0F766E` (Teal)
- **Persistence:** 
    - **Key:** `app_theme_seed_color`
    - **Storage:** `SharedPreferences` (stored as an integer or hex string)

### 2.2. Theme Integration
The `AppTheme` class will be refactored to accept a seed color.

- **File:** `lib/core/presentation/theme/app_theme.dart`
- **Change:** Modify `_buildTheme(Brightness brightness)` to take an additional `Color seedColor` parameter.
- **Change:** Update `lightTheme` and `darkTheme` static members to be methods or handled dynamically in `MyApp`.

### 2.3. Root Application Update
`MyApp` will watch the new provider and rebuild when the theme color changes.

- **File:** `lib/main.dart`
- **Change:** Watch `appThemeColorProvider` in `MyApp.build`.
- **Change:** Pass the current seed color to `AppTheme.buildTheme(Brightness.light/dark, seedColor)`.

## 3. UI Design

### 3.1. Settings Page Integration
The selector will be added to the "Appearance" section of the `SettingsPage`.

- **Components:**
    - **Horizontal Swatch Strip:** A scrollable row of circular color swatches.
    - **Presets:** Teal (`0xFF0F766E`), Blue (`0xFF2196F3`), Purple (`0xFF9C27B0`), Orange (`0xFFFF9800`), Red (`0xFFF44336`), Green (`0xFF4CAF50`), Grey (`0xFF9E9E9E`).
    - **Custom Swatch:** A final swatch with `Icons.palette_outlined`.
    - **Selection Indicator:** Active color will be highlighted (e.g., border or checkmark).
    - **Hex Input:** A `TextField` that appears only when "Custom" is active.
        - Label: "Custom Hex Color"
        - Hint: "#0F766E"
        - Validation: Validates for 6 or 8 character hex strings.

## 4. Testing & Validation
- Verify that selecting a preset color immediately updates the entire app UI.
- Verify that entering a valid Hex code updates the theme.
- Verify that invalid Hex codes do not crash the app and show an error message.
- Verify that the selected color persists after app restart.
- Verify that both Light and Dark modes respect the new seed color.
