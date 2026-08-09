# StashFlow v1.28.0

## ✨ New Features

### Gallery Details Image Browser

- Opening a gallery now shows its details and images together instead of jumping directly to the general image page.
- The compact gallery header includes cover art, title, date, rating, image count, description, studio, and performers.
- Studio and performer chips link directly to their detail pages.
- Gallery images retain the standard image browser's sorting, filtering, saved presets, pagination, and display controls.

### Studio Hierarchy

- Studio details now show parent and child studios when hierarchy information exists.
- Each related studio is selectable for quick navigation through the hierarchy.

## 🔎 Filtering & Sorting

### Images and Galleries

- Expanded image filters with date, tags, tag count, galleries, performer tags, performer count and age, performer favorites, checksum, and created or updated dates.
- Expanded gallery filters with linked scenes, performer tags, performer count and age, performer favorites, and average resolution.
- Corrected gallery file-count sorting to use the sort key supported by Stash.

### Tags and Groups

- Tag filtering now covers metadata, missing fields, favorites, automatic-tag behavior, parent and child relationships, usage counts, and created or updated dates.
- Group filtering now covers metadata, rating, studio, performer and tag relationships, containing and child groups, usage counts, and created or updated dates.
- Full tag filters can now be saved and restored through server-side presets instead of preserving only the favorites toggle.
- Corrected group, studio, and tag-related sort and filter keys to match the Stash API.

## 🎨 UI & UX Improvements

### Gallery Browsing

- The gallery header automatically collapses while scrolling to leave more room for images.
- Expanding the header preserves the current image-list position.
- Returning from the fullscreen image viewer restores the viewed image's position and keyboard focus.
- Refined the gallery header with Material 3 styling, responsive spacing, compact metadata badges, and clearer separation from the image grid.

## 🌐 Localization

- Added localized labels for studio hierarchy and the expanded filter options across all supported locales.

## 🧪 Testing

- Added coverage for gallery detail loading, the embedded image browser, header collapse and expansion, fullscreen focus restoration, studio hierarchy parsing and navigation, corrected sort keys, and expanded saved filters.
