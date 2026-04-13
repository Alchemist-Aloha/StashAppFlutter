# Desktop and Web UX Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Improve navigation, video control, and UI for desktop and web without affecting mobile.

**Architecture:** Layering desktop-specific capabilities (shortcuts, mouse interactions) using a new `desktopCapabilitiesProvider` and persistent `desktopSettingsProvider`.

**Tech Stack:** Flutter, Riverpod, Shared Preferences, GoRouter.

---

### Task 1: Core Desktop Providers

**Files:**
- Create: `lib/core/presentation/providers/desktop_capabilities_provider.dart`
- Create: `lib/core/presentation/providers/desktop_settings_provider.dart`

- [ ] **Step 1: Create DesktopCapabilities provider**
```dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final desktopCapabilitiesProvider = Provider<bool>((ref) {
  if (kIsWeb) return true;
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
});
```

- [ ] **Step 2: Create DesktopSettings provider**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopSettings {
  final double volume;
  final bool isMuted;

  DesktopSettings({this.volume = 1.0, this.isMuted = false});

  DesktopSettings copyWith({double? volume, bool? isMuted}) {
    return DesktopSettings(
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}

class DesktopSettingsNotifier extends StateNotifier<DesktopSettings> {
  DesktopSettingsNotifier() : super(DesktopSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      volume: prefs.getDouble('desktop_volume') ?? 1.0,
      isMuted: prefs.getBool('desktop_is_muted') ?? false,
    );
  }

  Future<void> setVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    state = state.copyWith(volume: clampedVolume);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('desktop_volume', clampedVolume);
  }

  Future<void> toggleMute() async {
    final newMute = !state.isMuted;
    state = state.copyWith(isMuted: newMute);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('desktop_is_muted', newMute);
  }
}

final desktopSettingsProvider =
    StateNotifierProvider<DesktopSettingsNotifier, DesktopSettings>((ref) {
  return DesktopSettingsNotifier();
});
```

- [ ] **Step 3: Commit Task 1**
```bash
git add lib/core/presentation/providers/desktop_capabilities_provider.dart lib/core/presentation/providers/desktop_settings_provider.dart
git commit -m "feat: add desktop capabilities and settings providers"
```

---

### Task 2: Global Navigation Shortcuts

**Files:**
- Modify: `lib/features/navigation/presentation/shell_page.dart`

- [ ] **Step 1: Import new providers**
```dart
import '../../../core/presentation/providers/desktop_capabilities_provider.dart';
import 'package:flutter/services.dart';
```

- [ ] **Step 2: Implement keyboard shortcuts in build method**
Wrap `bodyContent` with `CallbackShortcuts`.

- [ ] **Step 3: Commit Task 2**
```bash
git add lib/features/navigation/presentation/shell_page.dart
git commit -m "feat: add global navigation keyboard shortcuts"
```

---

### Task 3: Video Player State Integration

**Files:**
- Modify: `lib/features/scenes/presentation/providers/video_player_provider.dart`

- [ ] **Step 1: Add volume and mute methods to PlayerStateNotifier**
- [ ] **Step 2: Commit Task 3**
```bash
git add lib/features/scenes/presentation/providers/video_player_provider.dart
git commit -m "feat: integrate desktop volume/mute logic into video player provider"
```

---

### Task 4: Enhanced Video Controls

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`

- [ ] **Step 1: Add video shortcuts (Space, F, M, J, L, Arrows)**
- [ ] **Step 2: Add mouse wheel volume adjustment**
- [ ] **Step 3: Implement hover volume slider**
- [ ] **Step 4: Commit Task 4**
```bash
git add lib/features/scenes/presentation/widgets/native_video_controls.dart
git commit -m "feat: add video player keyboard shortcuts and mouse wheel volume control"
```

---

### Task 5: UI Feedback Overlays

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`

- [ ] **Step 1: Add status overlays for volume/mute changes**
- [ ] **Step 2: Commit Task 5**
```bash
git add lib/features/scenes/presentation/widgets/native_video_controls.dart
git commit -m "feat: add desktop status overlays for volume and mute"
```
