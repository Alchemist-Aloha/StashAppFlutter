# Desktop-Only FVP Video Playback Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable the `fvp` (libmdk) plugin specifically for Desktop platforms (Windows, Linux, macOS) to resolve playback issues while keeping Android and Web versions using their default, stable backends.

**Architecture:** Use Conditional Imports and Platform checks in `main.dart` to register `fvp` only on Desktop. This avoids introducing NDK dependencies or registration conflicts on Android.

**Tech Stack:** Flutter, `fvp` plugin (libmdk), Dart Platform checks.

---

### Task 1: Add FVP Dependency

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Add `fvp` to `dependencies`**

```yaml
dependencies:
  # ... existing dependencies ...
  fvp: ^0.23.0
```

- [ ] **Step 2: Run `flutter pub get`**

Run: `flutter pub get`
Expected: Success

- [ ] **Step 3: Commit**

```bash
git add pubspec.yaml
git commit -m "feat: add fvp dependency for desktop playback"
```

---

### Task 2: Implement Desktop-Only Registration

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Add FVP import and registration logic**

Modify `lib/main.dart` to import `fvp` and call `registerWith()` only on Desktop platforms.

```dart
// At the top of lib/main.dart
import 'package:fvp/fvp.dart' as fvp;
// ... other imports ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register fvp only on Desktop platforms.
  // We explicitly exclude Android and iOS to keep them on the default backend.
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    fvp.registerWith();
  }
  
  // ... rest of main ...
}
```

- [ ] **Step 2: Verify code compiles**

Run: `flutter analyze`
Expected: No errors related to `fvp` or `main.dart`

- [ ] **Step 3: Commit**

```bash
git add lib/main.dart
git commit -m "feat: enable fvp registration for desktop platforms only"
```

---

### Task 3: Exclude FVP from Android Build

**Files:**
- Modify: `android/app/build.gradle.kts`

- [ ] **Step 1: Add exclusion rule in app/build.gradle.kts**

This prevents the `fvp` plugin's native code and automatic registration from being included in the Android APK, restoring the default `video_player` behavior.

```kotlin
dependencies {
    // ...
}

// Add this at the end of the file or after the dependencies block
configurations.all {
    exclude(group = "com.mediadevkit.fvp")
}
```

- [ ] **Step 2: Revert NDK and minSdk changes (Optional but cleaner)**

Since `fvp` is now excluded, we can revert the manual `ndkVersion` and `minSdk` overrides if they are no longer needed.

- [ ] **Step 3: Run Android Build to verify**

Run: `flutter build apk`
Expected: SUCCESS, and the APK size should return to ~69MB.

- [ ] **Step 4: Commit**

```bash
git add android/app/build.gradle.kts
git commit -m "fix: exclude fvp from android build to restore default playback"
```

### Task 4: Final Verification (No Regression)
