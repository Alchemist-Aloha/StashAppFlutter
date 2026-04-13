# Codebase Restructuring Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reduce Technical Debt and Increase Test Coverage through Core-Driven Standardization.

**Architecture:** We will build a robust `lib/core` layer containing base classes for repositories, shared UI components, and common data mapping utilities. This will simplify feature-level code and make it more testable.

**Tech Stack:** Flutter, Riverpod, GraphQL (with codegen), Freezed.

---

### Task 1: Create BaseRepository

**Files:**
- Create: `lib/core/data/graphql/base_repository.dart`
- Test: `test/core/data/graphql/base_repository_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:stash_app_flutter/core/data/graphql/base_repository.dart';

class MockQueryResult extends Mock implements QueryResult {}

void main() {
  test('BaseRepository.validateResult throws on exception', () {
    final result = MockQueryResult();
    when(result.hasException).thenReturn(true);
    when(result.exception).thenReturn(OperationException(graphqlErrors: [GraphQLError(message: 'Error')]));

    expect(() => BaseRepository.validateResult(result), throwsException);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/data/graphql/base_repository_test.dart`
Expected: Compilation error (BaseRepository not defined).

- [ ] **Step 3: Implement BaseRepository**

```dart
import 'package:graphql/client.dart';

abstract class BaseRepository {
  static void validateResult(QueryResult result) {
    if (result.hasException) {
      throw result.exception!;
    }
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/core/data/graphql/base_repository_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/core/data/graphql/base_repository.dart test/core/data/graphql/base_repository_test.dart
git commit -m "feat: add BaseRepository for GraphQL result validation"
```

---

### Task 2: Create DataMapper Extensions

**Files:**
- Create: `lib/core/utils/data_mapper.dart`
- Test: `test/core/utils/data_mapper_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/core/utils/data_mapper.dart';

void main() {
  test('DataMapper.formatDuration formats seconds correctly', () {
    expect(DataMapper.formatDuration(3661), '1:01:01');
    expect(DataMapper.formatDuration(125), '02:05');
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/utils/data_mapper_test.dart`
Expected: FAIL (DataMapper not defined).

- [ ] **Step 3: Implement DataMapper**

```dart
class DataMapper {
  static String formatDuration(double? seconds) {
    if (seconds == null) return '00:00';
    final duration = Duration(seconds: seconds.toInt());
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/core/utils/data_mapper_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/core/utils/data_mapper.dart test/core/utils/data_mapper_test.dart
git commit -m "feat: add DataMapper utility for shared formatting logic"
```

---

### Task 3: Create Standardized Status Views

**Files:**
- Create: `lib/core/presentation/widgets/status_views.dart`
- Modify: `lib/core/presentation/widgets/error_state_view.dart` (Move or integrate)

- [ ] **Step 1: Implement LoadingStateView and ErrorStateView**

```dart
import 'package:flutter/material.dart';

class LoadingStateView extends StatelessWidget {
  const LoadingStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ErrorStateView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorStateView({required this.message, this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Verify visually (manual check or widget test)**

- [ ] **Step 3: Commit**

```bash
git add lib/core/presentation/widgets/status_views.dart
git commit -m "feat: add standardized LoadingStateView and ErrorStateView"
```

---

### Task 4: Create MediaCard and MediaHeader

**Files:**
- Create: `lib/core/presentation/widgets/media_widgets.dart`

- [ ] **Step 1: Implement MediaCard and MediaHeader**

```dart
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback? onTap;
  final Widget? subtitle;

  const MediaCard({
    required this.title,
    this.imageUrl,
    this.onTap,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: imageUrl != null
                  ? Image.network(imageUrl!, fit: BoxFit.cover)
                  : const ColoredBox(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/widgets/media_widgets.dart
git commit -m "feat: add generic MediaCard widget"
```

---

### Task 5: Enhance ListPageScaffold

**Files:**
- Modify: `lib/core/presentation/widgets/list_page_scaffold.dart`

- [ ] **Step 1: Add simplified search and sort parameters to ListPageScaffold**

```dart
// Modify the constructor and build method to support easier configuration
// of search bars and sort menus.
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/widgets/list_page_scaffold.dart
git commit -m "refactor: enhance ListPageScaffold for easier configuration"
```

---

### Task 6: Migration - Refactor Scene Repository

**Files:**
- Modify: `lib/features/scenes/data/repositories/graphql_scene_repository.dart`

- [ ] **Step 1: Use BaseRepository.validateResult**
- [ ] **Step 2: Move mapping to DataMapper extensions**
- [ ] **Step 3: Remove cross-feature logic (reconcile performers/tags)**
- [ ] **Step 4: Commit**

```bash
git commit -m "refactor: apply core-driven patterns to GraphQLSceneRepository"
```
