# StashFlow v1.32.0

## 🎬 TikTok Scene Feed

- Added a compact action menu to TikTok-style scene items for sorting, filtering, saved filters, and scene markers.
- Kept the feed focused by hiding secondary actions until the action menu is expanded.

## ▶️ Playback

- Paused borrowed video controllers when switching playback sessions, preventing the previous scene from continuing to play in the background.

## ⚡ Performance

- Reduced startup delays by opening the persistent GraphQL cache after the first frame while preserving cache changes made during launch.
- Smoothed masonry-grid scrolling by preparing more content ahead of the visible area, reducing stalls during faster browsing.

## 🔖 Saved Presets

- Saved and loaded official Stash preset formats for ranges, booleans, relationships, hierarchy depth and exclusions, pHash distance, and duplicate criteria.
- Kept valid presets available when another server preset contains an invalid payload.
- Matched current Stash filtering and sorting, including production dates, folders, custom fields, Stash IDs, missing-field selectors, recursive studio counts, and newer group and marker sorts.
