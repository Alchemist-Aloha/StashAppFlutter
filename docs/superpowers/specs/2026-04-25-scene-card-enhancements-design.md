# Design Spec: Scene Card Enhancements (Metadata, Hover Scrubbing, Desktop Context)

Date: 2026-04-25
Author: Gemini CLI

## 1. Overview
Enhance the `SceneCard` widget to improve information density and platform-specific interactivity. Key improvements include metadata overlays on thumbnails, desktop-optimized hover scrubbing, and expanded performer context for desktop users.

## 2. Requirements

### 2.1 Metadata Overlays (Grid & List)
- **Position:** Bottom of the thumbnail image.
- **Background:** Semi-transparent black bar for readability.
- **Data Points:**
    - **Left:** Play count (views).
    - **Center:** Numerical rating (converted from 100-point scale to 5.0 scale).
    - **Right:** Scene duration.
- **Visibility:** Enabled for both Grid and List modes.

### 2.2 Platform-Specific Scrubbing
- **Mobile (Android/iOS):** Maintain existing horizontal drag-to-scrub logic.
- **Desktop (Windows/macOS/Linux/Web):** Replace drag logic with horizontal `MouseRegion` hover. Scrub time scales linearly with mouse X-position relative to card width.

### 2.3 Desktop Expanded Context
- **Feature:** Show performer avatars next to the studio name in `SceneCard` footer on desktop.
- **Configuration:** Max number of avatars defaults to 3, user-configurable in Interface Settings.
- **Overflow:** If total performers exceed the limit, display a `+N` text indicator.

## 3. Architecture & Implementation

### 3.1 Data Model & Settings
- **Settings:** Update `AppSettings` (or equivalent provider) to include `maxPerformerAvatars` (int).
- **Scene Entity:** Use existing `playCount`, `rating100`, and `performerImagePaths`.

### 3.2 UI Components

#### Thumbnail Overlay
A new internal widget `_ThumbnailMetadataOverlay` will be created inside `scene_card.dart`:
- Uses `Row` with `MainAxisAlignment.spaceBetween`.
- Icon + Text pairs for Views and Rating.
- Text for Duration.

#### Platform Interaction Logic
- Use `kIsWeb` or `defaultTargetPlatform` to determine environment.
- Wrap thumbnail in `MouseRegion` for desktop.
- Logic: `_scrubTime = (localX / cardWidth) * totalDuration`.

#### Performer Avatar Row
A new internal widget `_PerformerAvatarRow` will be created:
- Takes `List<String?> imagePaths` and `int limit`.
- Uses `Row` with `CircleAvatar` widgets.
- Handles empty paths with a placeholder `Icons.person`.

## 4. Testing Strategy
- **Widget Tests:** Verify metadata bar rendering in both Grid and List modes.
- **Platform Simulation:** Test hover logic (desktop) vs drag logic (mobile) using `tester.binding.setSurfaceSize`.
- **Settings Integration:** Verify that changing `maxPerformerAvatars` correctly updates the avatar count in the UI.

## 5. Success Criteria
- [ ] View count and rating are visible on thumbnails.
- [ ] Hover scrubbing works on desktop without clicking.
- [ ] Performer avatars appear on desktop but are hidden on mobile.
- [ ] `+N` indicator appears correctly when performer count exceeds limit.
