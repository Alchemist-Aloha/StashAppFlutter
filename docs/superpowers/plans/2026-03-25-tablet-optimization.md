# Tablet Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Optimize StashFlow for tablet devices by introducing an adaptive navigation sidebar and a 3-column grid layout, while preserving the existing mobile UI.

**Architecture:** 
- Centralized `Responsive` utility for screen width detection.
- Adaptive `ShellPage` using `NavigationRail` for tablets and `NavigationBar` for mobile.
- Responsive `ListPageScaffold` that calculates grid columns based on screen width.

**Tech Stack:** Flutter, Riverpod, GoRouter.

---

### Task 1: Create Responsive Utility

**Files:**
- Create: `lib/core/utils/responsive.dart`
- Test: `test/core/utils/responsive_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stashflow/core/utils/responsive.dart';

void main() {
  testWidgets('Responsive utility identifies mobile and tablet widths', (tester) async {
    // Mobile width
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        expect(Responsive.isMobile(context), isTrue);
        expect(Responsive.isTablet(context), isFalse);
        return const SizedBox();
      }),
    ));

    // Tablet width
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pump();
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        expect(Responsive.isMobile(context), isFalse);
        expect(Responsive.isTablet(context), isTrue);
        return const SizedBox();
      }),
    ));
    
    // Reset size
    await tester.binding.setSurfaceSize(null);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/utils/responsive_test.dart`
Expected: FAIL (file not found)

- [ ] **Step 3: Implement Responsive utility**

```dart
import 'package:flutter/material.dart';

class Responsive {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint &&
      MediaQuery.sizeOf(context).width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/core/utils/responsive_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/core/utils/responsive.dart test/core/utils/responsive_test.dart
git commit -m "feat: add Responsive utility for screen size detection"
```

---

### Task 2: Implement Adaptive Navigation in ShellPage

**Files:**
- Modify: `lib/features/navigation/presentation/shell_page.dart`
- Test: `test/features/navigation/presentation/shell_page_test.dart`

- [ ] **Step 1: Update ShellPage to support NavigationRail**

```dart
// Modify build method in lib/features/navigation/presentation/shell_page.dart
// Wrap Scaffold body in a Row if !isMobile
// Move navigationShell into an Expanded in that Row
// Add NavigationRail as the first child of the Row
```

- [ ] **Step 2: Write widget test for adaptive navigation**

```dart
// Test that NavigationBar is visible at 400px width
// Test that NavigationRail is visible at 800px width
```

- [ ] **Step 3: Run tests**

Run: `flutter test test/features/navigation/presentation/shell_page_test.dart`
Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add lib/features/navigation/presentation/shell_page.dart
git commit -m "feat: implement adaptive navigation (Rail for tablet, Bar for mobile)"
```

---

### Task 3: Implement Responsive Grid in ListPageScaffold

**Files:**
- Modify: `lib/core/presentation/widgets/list_page_scaffold.dart`

- [ ] **Step 1: Update ListPageScaffold to calculate dynamic columns**

```dart
// In lib/core/presentation/widgets/list_page_scaffold.dart
// Add a helper method to calculate grid columns
int _getGridColumns(BuildContext context) {
  if (Responsive.isMobile(context)) return 2;
  return 3;
}
// Update GridView.builder to use this column count if gridDelegate is a 
// SliverGridDelegateWithFixedCrossAxisCount or provide a way to override.
```

- [ ] **Step 2: Update ScenesPage to use responsive grid**

**Files:**
- Modify: `lib/features/scenes/presentation/pages/scenes_page.dart`

```dart
// Update gridDelegate in ScenesPage build method
// Update _onScroll prefetch logic to use dynamic column count
```

- [ ] **Step 3: Verify visually and with existing tests**

Run: `flutter test`
Expected: All tests pass (no regressions on mobile)

- [ ] **Step 4: Commit**

```bash
git add lib/core/presentation/widgets/list_page_scaffold.dart lib/features/scenes/presentation/pages/scenes_page.dart
git commit -m "feat: implement 3-column grid for tablets in ScenesPage"
```

---

### Task 4: Update Other Grid Pages

**Files:**
- Modify: `lib/features/performers/presentation/pages/performer_media_grid_page.dart`
- Modify: `lib/features/studios/presentation/pages/studio_media_grid_page.dart`
- Modify: `lib/features/tags/presentation/pages/tag_media_grid_page.dart`

- [ ] **Step 1: Update grid delegates in all grid pages**

- [ ] **Step 2: Run all tests**

Run: `flutter test`
Expected: PASS

- [ ] **Step 3: Commit**

```bash
git add lib/features/performers/presentation/pages/performer_media_grid_page.dart \
        lib/features/studios/presentation/pages/studio_media_grid_page.dart \
        lib/features/tags/presentation/pages/tag_media_grid_page.dart
git commit -m "feat: apply 3-column grid to performers, studios, and tags on tablets"
```
