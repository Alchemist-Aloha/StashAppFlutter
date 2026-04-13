# Design: Preparing StashFlow for F-Droid Publishing

Date: 2026-04-13
Topic: F-Droid Publishing Preparation
Status: Approved

## Overview
StashFlow is a Flutter companion app for Stash. To be published on F-Droid's official repository, the app must be fully open-source, including all its dependencies. The current use of the `fvp` package (based on the proprietary `libmdk`) is a blocker for F-Droid. This design introduces a dual-flavor architecture to maintain a full-featured "standard" version while providing a strictly FOSS-compliant "foss" version for F-Droid.

## Goals
1.  Migrate the Application ID to a more descriptive and unique one: `io.github.alchemistaloha.stashflow`.
2.  Implement a dual-flavor Android build system (`standard` and `foss`).
3.  Ensure the `foss` flavor is strictly FOSS-compliant by excluding `fvp` proprietary binaries.
4.  Set up Fastlane metadata for automated F-Droid ingestion.
5.  Adapt the Flutter code to handle the presence or absence of the `fvp` plugin at runtime.

## Architecture & Implementation

### 1. Identity & Package Structure Migration
-   **Application ID:** Change from `com.github.alchemistaloha.stash_app_flutter` to `io.github.alchemistaloha.stashflow`.
-   **Android Namespace:** Update `namespace` in `android/app/build.gradle.kts`.
-   **Kotlin Source:** Move `MainActivity.kt` from `android/app/src/main/kotlin/com/github/damontecres/stash_app_flutter/` to `android/app/src/main/kotlin/io/github/alchemistaloha/stashflow/`.
-   **Dart Code:** Update hardcoded references to the old App ID (e.g., in `main.dart` for `AudioServiceConfig`).

### 2. Dual-Flavor Android Configuration
Modify `android/app/build.gradle.kts` to include:
-   `flavorDimensions += "version"`
-   `productFlavors`:
    -   `standard`: The default version for GitHub/Direct downloads. Includes `fvp`.
    -   `foss`: The version for F-Droid. Excludes `fvp` native libraries.

```kotlin
android {
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

### 3. FOSS Compliance & Dependency Management
-   **Dependency Exclusion:** In the `foss` build, we will use Gradle's `packagingOptions` or `configurations` to ensure no `libmdk` or `fvp` related native binaries are bundled.
-   **Runtime Check:** `lib/main.dart` will be updated to safely attempt `fvp` registration using a `try-catch` block or a conditional check based on the environment/flavor.

### 4. Fastlane Metadata
Create the standard Fastlane metadata structure for F-Droid:
-   `android/fastlane/metadata/android/en-US/title.txt`
-   `android/fastlane/metadata/android/en-US/short_description.txt`
-   `android/fastlane/metadata/android/en-US/full_description.txt`
-   `android/fastlane/metadata/android/en-US/changelogs/` (for future releases)

## Testing Strategy
1.  **Build Verification:** Run `flutter build apk --flavor standard` and `flutter build apk --flavor foss` to ensure both build successfully.
2.  **Binary Inspection:** Inspect the `foss` APK to verify that no `libmdk.so` or `libfvp.so` files are present.
3.  **Runtime Verification:** Run the `foss` flavor on an emulator/device and confirm that video playback falls back to the default `video_player` implementation (ExoPlayer) without crashing.
4.  **Metadata Verification:** Verify that the Fastlane directory is correctly structured.

## Rollout Plan
1.  Perform identity migration (App ID and folder moves).
2.  Apply Gradle changes for flavors.
3.  Update Dart code for runtime adaptation.
4.  Create Fastlane metadata files.
5.  Perform final verification builds.
