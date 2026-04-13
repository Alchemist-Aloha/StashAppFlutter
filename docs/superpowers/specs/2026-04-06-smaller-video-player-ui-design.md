# Design Spec: Smaller Video Player UI Elements

This document outlines the design changes required to scale down the UI elements in both the inline and full-screen video players to create a more compact and less intrusive overlay.

## 1. Seek Feedback Overlay
The transient overlay shown during seeking/dragging will be reduced in size.

| Property | Current | Proposed |
| :--- | :--- | :--- |
| **Padding** | `18x12` | `14x10` |
| **Font Size** | `15` | `13` |
| **Icon Size** | `20` | `18` |
| **Border Radius** | `24` | `18` |

## 2. Bottom Control Bar (Container)
The main container for the playback controls will be tightened.

| Property | Current | Proposed |
| :--- | :--- | :--- |
| **Outer Margin** | `8dp` | `6dp` |
| **Inner Padding** | `12x10, 12x8` | `10x8, 10x6` |
| **Corner Radius** | `AppTheme.radiusLarge` (20) | `AppTheme.radiusMedium` (14) |

## 3. Control Buttons & Interactive Elements
Individual control buttons (Play, Pause, Skip, Fullscreen) will be scaled down.

| Property | Current | Proposed |
| :--- | :--- | :--- |
| **Button Min Size** | `44x44` | `38x38` |
| **Button Padding** | `10` | `8` |
| **Icon Size** | `22` | `20` |
| **Corner Radius** | `14` | `10` |

## 4. Playback Slider
The progress bar will be made more subtle.

| Property | Current | Proposed |
| :--- | :--- | :--- |
| **Track Height** | `4` | `3` |
| **Thumb Radius** | `7` | `6` |
| **Overlay Radius** | `14` | `12` |
| **Drag Handle Width**| `34` | `28` |
| **Drag Handle Height**| `4` | `3` |

## 5. Text, Labels & Selectors
Metadata and status text will be reduced in size.

| Property | Current | Proposed |
| :--- | :--- | :--- |
| **Time/Speed Text** | `12` | `11` |
| **Speed Selector Pad**| `10x6` | `8x4` |
| **Speed Selector Radius**| `14` | `10` |
| **Fullscreen Title** | `16` | `14` |

## 6. Layout Adjustments
*   **Spacing:** Reduce spacing between buttons and text elements (e.g., from `8` to `6`, or `12` to `8`).
*   **Safe Area Padding:** Ensure top bar in fullscreen maintains appropriate `SafeArea` but with tighter internal padding.

## Success Criteria
*   The UI elements occupy less screen area.
*   Buttons remain easily tappable on mobile devices (target ~38dp min).
*   Text remains legible at a glance.
*   Consistent look and feel across inline and fullscreen modes.
