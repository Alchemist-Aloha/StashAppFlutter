import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_app_flutter/core/data/preferences/shared_preferences_provider.dart';
import 'package:stash_app_flutter/features/scenes/domain/entities/scene.dart';
import 'package:stash_app_flutter/features/scenes/domain/entities/scene_filter.dart';
import 'package:stash_app_flutter/features/scenes/domain/repositories/scene_repository.dart';
import 'package:stash_app_flutter/features/scenes/presentation/providers/scene_list_provider.dart';

class MockSceneRepository implements SceneRepository {
  bool throwErrorOnNextCall = false;
  final List<Scene> _scenes;
  int callCount = 0;

  MockSceneRepository(this._scenes);

  @override
  Future<List<Scene>> findScenes({
    int? page,
    int? perPage,
    String? filter,
    String? sort,
    bool descending = true,
    bool? organized,
    bool? performerFavorite,
    String? performerId,
    String? studioId,
    String? tagId,
    SceneFilter? sceneFilter,
  }) async {
    callCount++;
    if (throwErrorOnNextCall) {
      throwErrorOnNextCall = false;
      throw Exception('Mocked error');
    }

    // Simple pagination mock
    if (page == 1) return _scenes;
    if (page == 2) return []; // Simulate no more data

    return [];
  }

  @override
  Future<Scene> getSceneById(String id) async {
    return _scenes.firstWhere((scene) => scene.id == id);
  }

  @override
  Future<void> updateSceneRating(String id, int rating100) async {}

  @override
  Future<void> incrementSceneOCounter(String id) async {}

  @override
  Future<void> incrementScenePlayCount(String id) async {}
}

void main() {
  test('fetchNextPage handles errors gracefully', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final mockScene = Scene(
      id: 'scene-1',
      title: 'Alpha Scene',
      details: 'details',
      path: null,
      date: DateTime(2024, 1, 1),
      rating100: 80,
      oCounter: 0,
      organized: true,
      interactive: false,
      resumeTime: null,
      playCount: 1,
      files: const [],
      paths: const ScenePaths(screenshot: null, preview: null, stream: null),
      studioId: 'studio-1',
      studioName: 'Studio',
      studioImagePath: null,
      performerIds: const ['p1'],
      performerNames: const ['Performer'],
      performerImagePaths: const [null],
      tagIds: const ['t1'],
      tagNames: const ['Tag'],
    );

    final mockRepo = MockSceneRepository([mockScene]);

    final container = ProviderContainer(
      overrides: [
        sceneRepositoryProvider.overrideWithValue(mockRepo),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );

    addTearDown(container.dispose);

    // Initial state read to start the build() method
    final sceneListSubscription = container.listen(
      sceneListProvider,
      (_, __) {},
    );

    // Wait for initial load to finish
    await container.read(sceneListProvider.future);

    // Verify initial load state
    final state = container.read(sceneListProvider);
    expect(state.isLoading, false);
    expect(state.value?.length, 1);
    expect(container.read(sceneListProvider.notifier).hasMore, true);
    expect(container.read(sceneListProvider.notifier).isLoadingMore, false);

    // Configure the mock repository to throw an error on the next call
    mockRepo.throwErrorOnNextCall = true;

    // Call fetchNextPage which should trigger the exception
    await container.read(sceneListProvider.notifier).fetchNextPage();

    // Verify error was handled and state is consistent
    final stateAfterError = container.read(sceneListProvider);

    // Should still have previous data
    expect(stateAfterError.value?.length, 1);

    // Should still be false, as error is handled in finally block
    expect(container.read(sceneListProvider.notifier).isLoadingMore, false);

    // Should still be true since the error prevents from setting it to false
    expect(container.read(sceneListProvider.notifier).hasMore, true);

    // Should not be in error state according to the catch block implementation
    expect(stateAfterError.hasError, false);
  });
}
