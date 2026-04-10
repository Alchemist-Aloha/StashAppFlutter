
## 2024-05-28 - [Sync Deduplication in Flutter build()]
**Learning:** Performing deduplication *after* an async task within a Flutter `build` method is a performance trap. If a widget rebuilds rapidly (e.g., during scrolling), the async task won't complete before the next `build` fires, bypassing the deduplication check and spawning dozens of redundant async file system checks and network requests.
**Action:** Always maintain a synchronous `Set` of started/completed tasks to check *before* initiating expensive async operations or scheduling `addPostFrameCallback` from within `build()`.

## 2024-05-29 - [Hoist Invariant Layout Calculations from itemBuilder]
**Learning:** Performing invariant layout calculations (e.g., `MediaQuery.sizeOf(context)` or creating grid delegates) inside Flutter's `ListView.builder` or `GridView.builder` `itemBuilder` callbacks is an O(N) operation that applies significant GC pressure during scrolling.
**Action:** Always hoist invariant variables and layout calculations out of `itemBuilder` loops up to the `build` method.
## 2024-06-25 - Avoid MediaQuery.sizeOf inside ListView.builder/GridView.builder
**Learning:** Calling `MediaQuery.sizeOf(context)` inside the `itemBuilder` of a lazy list like `ListView.builder` or `GridView.builder` is a significant performance anti-pattern in Flutter. Because `itemBuilder` executes for every visible item during scrolling, it forces redundant, O(N) lookups up the widget tree on every frame. Even worse, it registers *every single list item* as a dependent on the `MediaQuery` inherited widget. If the media query changes (e.g., keyboard pops up or device rotates), the framework will forcibly rebuild *every list item individually*, causing massive jank and memory allocation pressure.
**Action:** Always hoist invariant layout calculations, especially `MediaQuery.sizeOf(context)`, out of the `itemBuilder` closure. Wrap the list/grid in a `Builder` widget to access the scoped context, compute the layout values exactly once, and capture those values in the `itemBuilder`'s closure scope.
