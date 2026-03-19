import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/scene.dart';
import 'scene_list_provider.dart';

part 'scene_details_provider.g.dart';

@riverpod
FutureOr<Scene> sceneDetails(Ref ref, String id) async {
  final repository = ref.watch(sceneRepositoryProvider);
  return repository.getSceneById(id);
}
