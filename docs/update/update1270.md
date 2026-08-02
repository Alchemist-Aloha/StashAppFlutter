# StashFlow v1.27.0

## 🎨 UI & UX Improvements

### Image Fullscreen Loading

- Adjacent fullscreen images now warm their source files without decoding full-resolution images in advance, reducing unnecessary memory use while keeping nearby images ready.

### Video Fullscreen Navigation

- On Android, pressing Back while a video is fullscreen now exits fullscreen first and returns to the currently active scene details page.
- Fullscreen navigation remains correct when playback changes to another scene or when scene IDs share numeric prefixes.

## 🛡️ Playback & Stability

### Android Media Volume

- Video volume gestures on Android now adjust the device's system media volume and display the resulting percentage.
- Small gesture deltas accumulate until they produce a meaningful volume step, making fine-grained swipes responsive.
- Invalid or unavailable system-volume requests fail safely without disrupting playback.

### Desktop Volume Settings

- Desktop volume and mute state are now session-local instead of being persisted in the app configuration backup.

## 🔧 Platform & Build Updates

### Android

- Applied the Kotlin Android plugin to the JNI subproject so Android builds continue to configure native Kotlin/JNI dependencies correctly.
- Updated the Android/JNI-related dependency lockfile entries and other package versions.

## 🧪 Testing

- Added Android `MainActivity` coverage for accumulated media-volume gestures.
- Added integration coverage for Android fullscreen Back behavior across active-scene and route changes.
- Updated fullscreen image-loading and desktop-settings tests for the new behavior.
