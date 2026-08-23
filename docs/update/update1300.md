# StashFlow v1.30.0

## 🎬 Playback & Fullscreen

- Added a setting to open selected and random scenes directly in fullscreen.
- Improved fullscreen orientation handling for portrait and landscape videos on phones and tablets.
- Disabled double-tap seeking by default to prevent accidental jumps during playback.
- Preserved random-feed and resume positions when the player state changes.

## ⚡ Browsing Performance

- Smoothed list paging by loading the next page before reaching the end.
- Reduced unnecessary list rendering work and improved image prefetching for scene and gallery strips.

## 📦 Release Packaging

- Added consistent versioned artifact names for Android, Linux, macOS, Windows, and web releases.
- Included platform and architecture details in release filenames to make downloads easier to identify.
- Improved Android update downloads by selecting the APK that matches the device architecture.

## 🔧 Maintenance

- Updated dependencies for compatibility and reliability.
- Simplified GraphQL code generation configuration and excluded generated platform files from static analysis.
