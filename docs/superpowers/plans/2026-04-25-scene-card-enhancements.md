# Scene Card Enhancements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enhance `SceneCard` with metadata overlays, platform-aware scrubbing (hover for desktop, drag for mobile), and desktop-only performer avatars.

**Architecture:** 
- Extend `LayoutSettings` with `maxPerformerAvatars` preference.
- Refactor `SceneCard` internal components into smaller, testable widgets.
- Use `kIsWeb` and `defaultTargetPlatform` for platform-specific interactions and layouts.

**Tech Stack:** Flutter, Riverpod, Shared Preferences.

---

### Task 1: Update Data Model & Localization

**Files:**
- Modify: `lib/core/presentation/providers/layout_settings_provider.dart`
- Modify: `lib/l10n/app_en.arb`

- [ ] **Step 1: Add `MaxPerformerAvatars` provider**

```dart
@riverpod
class MaxPerformerAvatars extends _$MaxPerformerAvatars {
  static const _storageKey = 'max_performer_avatars';

  @override
  int build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getInt(_storageKey) ?? 3;
  }

  Future<void> set(int value) async {
    if (state == value) return;
    state = value;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(_storageKey, value);
  }
}
```

- [ ] **Step 2: Add localization strings**

Add to `lib/l10n/app_en.arb`:
```json
  "settings_interface_max_performer_avatars": "Max Performer Avatars (Desktop)",
  "settings_interface_max_performer_avatars_subtitle": "Maximum number of performer avatars to show in the scene card on desktop.",
```

- [ ] **Step 3: Commit**

```bash
git add lib/core/presentation/providers/layout_settings_provider.dart lib/l10n/app_en.arb
git commit -m "feat: add maxPerformerAvatars setting and localization"
```

### Task 2: Update Interface Settings UI

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/interface_settings_page.dart`

- [ ] **Step 1: Update `_InterfaceSettingsPageState` to handle the new setting**

- Add `int _maxPerformerAvatars = 3;`
- Update `_load()` to read from `maxPerformerAvatarsProvider`.
- Update `_saveSettings()` to save to `maxPerformerAvatarsProvider.notifier`.

- [ ] **Step 2: Add setting row to UI**

Add `_buildGridColumnSetting` (reusing it for int selection) in the `SettingsSectionCard` for scenes or a new section.

- [ ] **Step 3: Commit**

```bash
git add lib/features/setup/presentation/pages/settings/interface_settings_page.dart
git commit -m "feat: add max performer avatars setting to interface settings page"
```

### Task 3: Implement Metadata Overlay Widget

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`

- [ ] **Step 1: Create `_ThumbnailMetadataOverlay` internal widget**

```dart
class _ThumbnailMetadataOverlay extends StatelessWidget {
  const _ThumbnailMetadataOverlay({
    required this.playCount,
    required this.rating,
    required this.duration,
    required this.isGrid,
  });

  final int playCount;
  final int? rating;
  final String duration;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildItem(Icons.visibility, playCount.toString()),
          if (rating != null)
            _buildItem(Icons.star, (rating! / 20.0).toStringAsFixed(1)),
          Text(
            duration,
            style: TextStyle(
              color: Colors.white,
              fontSize: isGrid ? 10 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: isGrid ? 10 : 12),
        const SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: isGrid ? 10 : 12,
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/scenes/presentation/widgets/scene_card.dart
git commit -m "ui: implement _ThumbnailMetadataOverlay in SceneCard"
```

### Task 4: Implement Performer Avatar Row Widget

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`

- [ ] **Step 1: Create `_PerformerAvatarRow` internal widget**

```dart
class _PerformerAvatarRow extends ConsumerWidget {
  const _PerformerAvatarRow({
    required this.performerImagePaths,
    required this.performerNames,
  });

  final List<String?> performerImagePaths;
  final List<String> performerNames;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limit = ref.watch(maxPerformerAvatarsProvider);
    final count = performerImagePaths.length;
    final displayCount = count > limit ? limit : count;
    final overflow = count > limit ? count - limit : 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < displayCount; i++)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: CircleAvatar(
              radius: 8,
              backgroundImage: performerImagePaths[i] != null
                  ? NetworkImage(performerImagePaths[i]!) // Note: Needs StashImage equivalent logic for headers
                  : null,
              child: performerImagePaths[i] == null
                  ? const Icon(Icons.person, size: 8)
                  : null,
            ),
          ),
        if (overflow > 0)
          Text(
            '+$overflow',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
```
*Note: Use `StashImage` logic for authenticated images in avatars.*

- [ ] **Step 2: Commit**

```bash
git add lib/features/scenes/presentation/widgets/scene_card.dart
git commit -m "ui: implement _PerformerAvatarRow in SceneCard"
```

### Task 5: Integrate Enhancements into SceneCard

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`

- [ ] **Step 1: Refactor `_buildThumbnail` to use `_ThumbnailMetadataOverlay` and add Hover Scrubbing**

- Determine `isDesktop` via `foundation.kIsWeb || (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)`.
- Wrap in `MouseRegion` for desktop.
- Update `onHover` for `_scrubTime` calculation.

- [ ] **Step 2: Update `_buildGridCard` and `_buildListCard` to include `_PerformerAvatarRow` on desktop**

- Use `isDesktop` check.
- Add `_PerformerAvatarRow` next to studio name.

- [ ] **Step 3: Commit**

```bash
git add lib/features/scenes/presentation/widgets/scene_card.dart
git commit -m "feat: integrate metadata overlay, hover scrubbing, and performer avatars into SceneCard"
```

### Task 6: Verification & Testing

**Files:**
- Modify: `test/features/scenes/presentation/widgets/scene_card_test.dart`

- [ ] **Step 1: Add tests for metadata overlay visibility**
- [ ] **Step 2: Add tests for desktop avatar row visibility**
- [ ] **Step 3: Run all tests**

Run: `flutter test test/features/scenes/presentation/widgets/scene_card_test.dart`
Expected: ALL PASS

- [ ] **Step 4: Commit**

```bash
git add test/features/scenes/presentation/widgets/scene_card_test.dart
git commit -m "test: add tests for SceneCard enhancements"
```
