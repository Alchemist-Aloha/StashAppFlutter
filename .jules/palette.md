## 2024-05-24 - [Semantic IconButtons]
**Learning:** Adding a `tooltip` property to an `IconButton` in Flutter is a highly effective micro-UX improvement that serves a dual purpose: providing a visual hint on desktop/web hover, and serving as the semantic accessibility label (ARIA equivalent) for screen readers. Replacing empty `InkWell` + `Icon` combinations with `IconButton` makes this much easier.
**Action:** Always prefer `IconButton` with a defined `tooltip` over wrapping an `Icon` in a gesture detector when semantic meaning is required for an icon-only action.
