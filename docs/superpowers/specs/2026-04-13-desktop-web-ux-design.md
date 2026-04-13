# Spec: Desktop and Web Experience Enhancements

**Date:** 2026-04-13
**Status:** Draft
**Topic:** Improving navigation, video control, and UI for desktop (Windows, Linux, macOS) and web without affecting the mobile-first experience.

## 1. Executive Summary
This document outlines the design for enhancing the StashFlow desktop and web experience. The goal is to provide desktop power-user features (keyboard shortcuts, mouse interactions, and enhanced UI feedback) while strictly maintaining the mobile-first design philosophy. These enhancements will be "layered" on top of the existing mobile UI, ensuring zero impact on touch-based usage.

## 2. Architecture & State Management

### 2.1 Capability-Based Logic
Instead of platform-specific checks, we will use a "capability-based" approach.
- **DesktopCapabilities Provider**: A Riverpod provider that determines if the current environment supports desktop-like interactions (e.g., keyboard, mouse wheel, hover).
- **Persistent Desktop State**: A `DesktopSettings` provider to store desktop-only preferences:
    - `volume`: 0.0 to 1.0 (defaults to 1.0).
    - `isMuted`: Boolean.
    - `lastWindowMode`: (Optional) Tracking window state.

### 2.2 Global Interaction Layer
- **Shortcut Manager**: A `Focus` and `CallbackShortcuts` wrapper in `ShellPage` to handle global app shortcuts.
- **Mouse Interaction Layer**: Use `MouseRegion` and `Listener` widgets to handle hover and scroll events without adding weight to mobile touch targets.

## 3. Navigation & Layout Enhancements

### 3.1 Keyboard Navigation
- **Tab Switching**: Keys `1`-`9` will switch between visible navigation tabs in the `NavigationRail` or `NavigationBar`.
- **Search Focus**: The `/` key will automatically focus the search bar (if present on the current page).

### 3.2 Visual Feedback (Hover)
- **Navigation Rail**: Subtle background highlights or color shifts when hovering over icons.
- **Interactive Elements**: Buttons and cards will gain hover states to provide immediate visual feedback for mouse users.

### 3.3 Scrolling
- **Consistent Friction**: Ensure mouse-wheel scrolling feels natural across all platforms, especially on Web where default scrolling can sometimes feel "choppy" in Flutter.

## 4. Video Control & UI

### 4.1 Enhanced Keyboard Shortcuts
Available only when the video player is active or in fullscreen:
- `Space`: Toggle Play/Pause.
- `f`: Toggle Fullscreen.
- `m`: Toggle Mute.
- `j` / `l`: Seek backward/forward 10 seconds.
- `Arrow Left` / `Arrow Right`: Seek backward/forward 5 seconds.
- `Arrow Up` / `Arrow Down`: Increase/Decrease volume by 5%.

### 4.2 Mouse Interactions
- **Volume Control**:
    - A volume slider will appear **only when hovering** over the volume icon.
    - **Mouse Wheel**: Scrolling over the video player will adjust the volume.
- **Double-Click**: Quickly toggle between windowed and fullscreen mode.

### 4.3 UI Feedback
- **Status Overlays**: Brief icons/labels (e.g., a volume bar or a "Muted" icon) will appear in the center of the video player when volume is adjusted or mute is toggled, providing clear feedback for non-touch interactions.

## 5. Web-Specific Considerations
- **Browser Fullscreen**: Use the `dart:html` (or `package:web`) API to trigger browser-level fullscreen where appropriate.
- **PWA Support**: Ensure keyboard shortcuts don't conflict with common browser shortcuts.

## 6. Testing Strategy
- **Unit Tests**: Verify `DesktopSettings` provider logic (volume clamping, mute toggling).
- **Widget Tests**: Mock keyboard events to ensure shortcuts trigger the correct navigation and player actions.
- **Manual Verification**: Test hover states and mouse-wheel volume adjustment on Windows, Linux, and Web targets.
