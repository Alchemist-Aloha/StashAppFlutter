import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_app_flutter/core/data/preferences/shared_preferences_provider.dart';
import 'package:stash_app_flutter/features/scenes/domain/entities/scene.dart';
import 'package:stash_app_flutter/features/scenes/domain/entities/scene_filter.dart';
import 'package:stash_app_flutter/features/scenes/domain/repositories/scene_repository.dart';
import 'package:stash_app_flutter/features/scenes/presentation/providers/scene_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlowRandomRepository implements SceneRepository {
  final List<Scene> _scenes;

  SlowRandomRepository(this._scenes);

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
    if (sort == 'random') {
       // Simulate slow random sort
       await Future.delayed(Duration(milliseconds: 500));
       _scenes.shuffle();
       return _scenes.take(perPage ?? 1).toList();
    }
    return _scenes.take(perPage ?? 1).toList();
  }

  @override
  Future<int> getSceneCount({
    String? filter,
    bool? organized,
    bool? performerFavorite,
    String? performerId,
    String? studioId,
    String? tagId,
    SceneFilter? sceneFilter,
  }) async {
    return _scenes.length;
  }

  @override
  Future<Scene> getSceneById(String id) async => _scenes.first;
  @override
  Future<void> updateSceneRating(String id, int rating100) async {}
  @override
  Future<void> incrementSceneOCounter(String id) async {}
  @override
  Future<void> incrementScenePlayCount(String id) async {}
}

void main() {
  test('getRandomScene performance', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final scenes = List.generate(10, (i) => Scene(
        id: 'scene-$i',
        title: 'Scene $i',
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
      ));

    final repo = SlowRandomRepository(scenes);

    final container = ProviderContainer(
      overrides: [
        sceneRepositoryProvider.overrideWithValue(repo),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ]
    );

    final provider = container.read(sceneListProvider.notifier);

    final stopwatch = Stopwatch()..start();
    final scene = await provider.getRandomScene();
    stopwatch.stop();

    print('getRandomScene took ${stopwatch.elapsedMilliseconds} ms');
    expect(scene, isNotNull);
  });
}
