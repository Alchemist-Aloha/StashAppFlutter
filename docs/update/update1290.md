# StashFlow v1.29.0

## 📦 Desktop Packaging

- Added release packaging for Linux AppImage, Debian, Pacman, and RPM distributions.
- Added Windows executable packaging with consistent StashFlow artifact names.
- Updated release workflows to build and publish Linux and Windows packages automatically.

## 🎨 UI & UX Improvements

### Scroll-Aware App Bars

- Added an optional setting to hide list-page top app bars while scrolling down and restore them while scrolling up.
- Added localized labels and descriptions for the new interface setting across supported locales.

### Playback Navigation

- Returning to the scene list now restores focus to the scene opened for playback.
- Random scene navigation restores the relevant playlist position and focus.
- Opening the playlist now brings the active scene into view and gives it focus.

## 🧪 Testing

- Added coverage for scroll-aware list app bars, scene-return focus, playlist focus, random navigation state, and the new interface setting.
