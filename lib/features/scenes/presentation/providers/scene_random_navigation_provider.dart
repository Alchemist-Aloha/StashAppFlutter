import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../setup/presentation/providers/navigation_customization_provider.dart';
import '../../domain/entities/scene.dart';
import 'scene_list_provider.dart';

final sceneRandomNavigationControllerProvider =
    Provider<SceneRandomNavigationController>(
      SceneRandomNavigationController.new,
    );

final sceneListRandomReturnProvider =
    NotifierProvider<SceneListRandomReturn, bool>(SceneListRandomReturn.new);

/// Tracks whether scene-list return focus should use the retained playlist.
class SceneListRandomReturn extends Notifier<bool> {
  @override
  bool build() => false;

  void markRandom() => state = true;

  void reset() => state = false;
}

class SceneRandomNavigationController {
  const SceneRandomNavigationController(this.ref);

  final Ref ref;

  Future<Scene?> getRandomScene({String? excludeSceneId}) async {
    final useCurrentFilter = ref.read(sceneRandomRespectActiveFilterProvider);
    final scene = await ref
        .read(sceneListProvider.notifier)
        .getRandomScene(
          useCurrentFilter: useCurrentFilter,
          excludeSceneId: excludeSceneId,
        );
    if (scene != null) {
      ref.read(sceneListRandomReturnProvider.notifier).markRandom();
    }
    return scene;
  }
}
