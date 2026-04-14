# F-Droid Preparation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prepare StashFlow for F-Droid by migrating the Application ID, implementing a dual-flavor build system, and ensuring FOSS compliance.

**Architecture:** Dual-flavor Android build (`standard` and `foss`). Identity migration (App ID and Kotlin package). Runtime adaptation in Dart for optional plugins. Fastlane metadata for store ingestion.

**Tech Stack:** Flutter, Gradle (KTS), Fastlane.

---

## File Structure

- `android/app/build.gradle.kts`: Define `standard` and `foss` flavors, update `namespace` and `applicationId`.
- `android/app/src/main/kotlin/io/github/alchemistaloha/stashflow/MainActivity.kt`: New location for the main Android activity.
- `android/app/src/main/AndroidManifest.xml`: Update package name and references.
- `lib/main.dart`: Runtime adaptation for `fvp` plugin.
- `android/fastlane/metadata/android/en-US/`: Store metadata files (title, descriptions).

---

## Tasks

### Task 1: Identity Migration - Directory Structure

**Files:**
- Create: `android/app/src/main/kotlin/io/github/alchemistaloha/stashflow/MainActivity.kt`
- Delete: `android/app/src/main/kotlin/com/github/damontecres/stash_app_flutter/MainActivity.kt`

- [ ] **Step 1: Create the new directory structure**
Run: `mkdir -p android/app/src/main/kotlin/io/github/alchemistaloha/stashflow`

- [ ] **Step 2: Move and update MainActivity.kt**
```kotlin
package io.github.alchemistaloha.stashflow

import android.app.PictureInPictureParams
import android.content.res.Configuration
import android.os.Build
import android.util.Rational
import io.flutter.embedding.engine.FlutterEngine
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceActivity() {
	private val pipChannel = "stash_app_flutter/pip"
	private var channel: MethodChannel? = null

	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)

		channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, pipChannel)
		channel?.setMethodCallHandler { call, result ->
			when (call.method) {
				"enterPictureInPicture" -> {
					val numerator = call.argument<Int>("numerator") ?: 1
					val denominator = call.argument<Int>("denominator") ?: 1
					result.success(enterPipMode(numerator, denominator))
				}
				else -> result.notImplemented()
			}
		}
	}

	private fun enterPipMode(numerator: Int, denominator: Int): Boolean {
		if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
			return false
		}
		return try {
			val builder = PictureInPictureParams.Builder()
			val aspectRatio = Rational(numerator, denominator)
			builder.setAspectRatio(aspectRatio)
			enterPictureInPictureMode(builder.build())
		} catch (_: Throwable) {
			false
		}
	}

	override fun onPictureInPictureModeChanged(isInPictureInPictureMode: Boolean, newConfig: Configuration?) {
		super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
		channel?.invokeMethod("pipModeChanged", isInPictureInPictureMode)
	}
}
```

- [ ] **Step 3: Remove the old directory**
Run: `rm -rf android/app/src/main/kotlin/com/github/damontecres`

- [ ] **Step 4: Commit**
Run: `git add android/app/src/main/kotlin && git commit -m "refactor: migrate Android package to io.github.alchemistaloha.stashflow"`

### Task 2: Identity Migration - Android Configuration

**Files:**
- Modify: `android/app/build.gradle.kts`
- Modify: `android/app/src/main/AndroidManifest.xml`

- [ ] **Step 1: Update namespace and applicationId in build.gradle.kts**
```kotlin
android {
    namespace = "io.github.alchemistaloha.stashflow"
    // ...
    defaultConfig {
        applicationId = "io.github.alchemistaloha.stashflow"
        // ...
    }
}
```

- [ ] **Step 2: Update AndroidManifest.xml**
Ensure the `<manifest>` tag does not have a hardcoded package (it should use the one from Gradle) or update it if present. Update any explicit references.

- [ ] **Step 3: Commit**
Run: `git add android/app/build.gradle.kts android/app/src/main/AndroidManifest.xml && git commit -m "feat: update Android Application ID to io.github.alchemistaloha.stashflow"`

### Task 3: Dual-Flavor Implementation

**Files:**
- Modify: `android/app/build.gradle.kts`

- [ ] **Step 1: Define flavor dimensions and product flavors**
```kotlin
android {
    // ...
    flavorDimensions.add("version")
    productFlavors {
        create("standard") {
            dimension = "version"
            applicationIdSuffix = ""
        }
        create("foss") {
            dimension = "version"
            applicationIdSuffix = ".foss"
            versionNameSuffix = "-foss"
        }
    }
}
```

- [ ] **Step 2: Commit**
Run: `git add android/app/build.gradle.kts && git commit -m "feat: implement standard and foss build flavors"`

### Task 4: FOSS Compliance - Binary Exclusion

**Files:**
- Modify: `android/app/build.gradle.kts`

- [ ] **Step 1: Exclude fvp native libraries from foss build**
```kotlin
android {
    // ...
    packaging {
        jniLibs {
            flavors {
                getByName("foss") {
                    excludes.add("**/libfvp.so")
                    excludes.add("**/libmdk.so")
                }
            }
        }
    }
}
```

- [ ] **Step 2: Commit**
Run: `git add android/app/build.gradle.kts && git commit -m "build: exclude fvp binaries from foss flavor"`

### Task 5: Runtime Adaptation in Dart

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Update hardcoded App ID references**
```dart
          androidNotificationChannelId:
              'io.github.alchemistaloha.stashflow.channel.audio',
```

- [ ] **Step 2: Implement safe fvp initialization**
```dart
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    try {
      fvp.registerWith(
        options: {
          'platforms': ['windows', 'linux', 'macos'],
        },
      );
    } catch (e) {
      debugPrint('fvp registration failed (expected in FOSS build): $e');
    }
    await windowManager.ensureInitialized();
  }
```

- [ ] **Step 3: Commit**
Run: `git add lib/main.dart && git commit -m "feat: adapt main.dart for runtime flavor adaptation and new App ID"`

### Task 6: Fastlane Metadata Setup

**Files:**
- Create: `android/fastlane/metadata/android/en-US/title.txt`
- Create: `android/fastlane/metadata/android/en-US/short_description.txt`
- Create: `android/fastlane/metadata/android/en-US/full_description.txt`

- [ ] **Step 1: Create metadata directory**
Run: `mkdir -p android/fastlane/metadata/android/en-US`

- [ ] **Step 2: Write title.txt**
Content: `StashFlow`

- [ ] **Step 3: Write short_description.txt**
Content: `A modern Flutter companion app for browsing and managing your Stash library.`

- [ ] **Step 4: Write full_description.txt**
(Extracting key points from README)
Content: 
```text
StashFlow is a powerful, modern mobile companion for your Stash media library. 

Features:
- Browse your entire Stash collection: Scenes, Images, Performers, Studios, and Galleries.
- High-performance video playback with PiP (Picture-in-Picture) support.
- Advanced filtering and sorting to find exactly what you're looking for.
- Securely connect to your Stash instance using API keys.
- Beautiful, responsive UI that feels native on your device.

Take your Stash library anywhere with StashFlow.
```

- [ ] **Step 5: Commit**
Run: `git add android/fastlane && git commit -m "docs: add Fastlane metadata for F-Droid"`

### Task 7: Verification Builds

- [ ] **Step 1: Build standard flavor**
Run: `flutter build apk --flavor standard`

- [ ] **Step 2: Build foss flavor**
Run: `flutter build apk --flavor foss`

- [ ] **Step 3: Verify binary exclusion in foss APK**
Run: `unzip -l build/app/outputs/flutter-apk/app-foss-release.apk | grep libfvp.so`
Expected: No output.

- [ ] **Step 4: Final Commit (if any fixes were needed)**
Run: `git commit -am "chore: final verification and fixes for F-Droid preparation"`
