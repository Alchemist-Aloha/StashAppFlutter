# Roadmap & TODO

## Short-term Goals

- [ ] **Customizable Navigation:** Add a setting to toggle the visibility of floating random navigation buttons.
- [ ] **Advanced Discovery:** Expand sorting and filtering options for Performers, Studios, and Tags to match the depth of the Scenes page.
- [ ] **Playlist Strategy Review:** Evaluate the necessity of a formal "Playlist" feature versus dynamically using the current query sequence (following the active sort order).
- [ ] **Playback Queue Fixes:** Investigate and fix the "Play Next" logic to ensure reliable transitions between scenes in the queue.
- [ ] **Scene Rating:** Implement the ability to rate scenes directly from the details page.
- [ ] **Data Fetching Optimization:**
    - **List Pages:** Reduce redundant API calls in primary list views (Scenes, Performers, etc.); data should ideally only re-fetch on manual pull-to-refresh.
    - **Media Strips:** Resolve the "double-refresh" issue in horizontal scroll widgets during navigation transitions.

## Long-term Goals

- [ ] **Extended Scraping:** Implement metadata scraping functionality for Performers and Studios.
- [ ] **Batch Operations:** Develop batch scraping capabilities for updating multiple items simultaneously.
