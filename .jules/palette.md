## 2025-02-28 - Tooltips for Dynamic State Toggles
**Learning:** In Flutter, adding a `tooltip` to an `IconButton` automatically sets its semantic accessibility label for screen readers. For dynamic state toggles like password visibility (`_obscurePassword`), the tooltip must conditionally update its text (e.g., 'Show password' vs 'Hide password') to maintain accurate screen reader announcements matching the visual state.
**Action:** When adding or reviewing tooltips on toggle buttons, always ensure the tooltip text dynamically reflects the active state rather than using a static label.
