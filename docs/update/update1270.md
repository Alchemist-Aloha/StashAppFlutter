# StashFlow v1.27.0

## ✨ New Features

### Image Details Sheet

- Added an **Image Details** bottom sheet, accessible from image cards and the fullscreen image viewer's info button.
- Shows the image title, studio, performers, ID, date, URL, resolution, and original file path.
- Studio and performer rows are tappable and jump straight to the corresponding studio or performer page.

### Gallery & Image Studio/Performer Info

- Gallery cards now show the studio name and, when performer avatars are enabled, a row of performer avatars.
- Gallery and image details sheets include studio and performer sections with the same quick navigation to studio or performer pages.

### More From Performer — Scene Details

- The scene details page now shows a **More from {performer}** section for each performer, listing related scenes in the playback queue.
- Each section includes a **View all** action that opens the performer's media page.

## 🎨 UI & UX Improvements

### Video Controls — Play/Pause Emphasis

- The play/pause button is now visually emphasized with a filled background and a larger touch target in both inline and fullscreen layouts.
- Play and pause icons transition with a spring animation when playback state changes.
- Control buttons were restyled for consistent sizing and grouped in a unified dark rounded container.

### Image Fullscreen Viewer

- Fullscreen viewer controls were reorganized: rating, download, and slideshow actions now sit in a single footer row alongside navigation, with the progress bar below.
- Adjacent fullscreen images now warm their source files without decoding full-resolution images in advance, reducing unnecessary memory use while keeping nearby images ready.

### Video Fullscreen Navigation

- On Android, pressing Back while a video is fullscreen now exits fullscreen first and returns to the currently active scene details page.
- Fullscreen navigation remains correct when playback changes to another scene or when scene IDs share numeric prefixes.

### Related Media Ordering

- Related media sections on the scene details page were reordered for a more natural flow.

## 🛡️ Playback & Stability

### Android Media Volume

- Video volume gestures on Android now adjust the device's system media volume and display the resulting percentage.
- Small gesture deltas accumulate until they produce a meaningful volume step, making fine-grained swipes responsive.
- Invalid or unavailable system-volume requests fail safely without disrupting playback.

### Desktop Volume Settings

- Desktop volume and mute state are now session-local instead of being persisted in the app configuration backup.

## 🌐 Localization

- Added translations for the new image details, rating, and "more from performer" features across all supported locales.

## 🔧 Platform & Build Updates

### Android

- Applied the Kotlin Android plugin to the JNI subproject so Android builds continue to configure native Kotlin/JNI dependencies correctly.
- Updated the Android/JNI-related dependency lockfile entries and other package versions.

### App Icon

- Updated the app icon across all platforms (Android, iOS, macOS, Windows, Linux, and web) and added the original SVG source plus a GitHub social preview image.

## 🧪 Testing

- Added Android `MainActivity` coverage for accumulated media-volume gestures.
- Added integration coverage for Android fullscreen Back behavior across active-scene and route changes.
- Added coverage for the new image details sheet, rating interactions, studio/performer rendering, "more from performer" sections, and the restyled video controls.
- Updated fullscreen image-loading and desktop-settings tests for the new behavior.
