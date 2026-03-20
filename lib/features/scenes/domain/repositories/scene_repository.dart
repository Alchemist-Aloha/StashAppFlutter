import '../entities/scene.dart';
import '../entities/scene_filter.dart';
import '../entities/scraper.dart';

abstract class SceneRepository {
  Future<List<Scene>> findScenes({
    int? page,
    int? perPage,
    String? filter,
    String? sort,
    bool descending = true,
    bool? organized,
    String? performerId,
    String? studioId,
    String? tagId,
    SceneFilter? sceneFilter,
  });
  Future<Scene> getSceneById(String id);

  Future<List<Scraper>> listSceneScrapers();
  Future<List<ScrapedScene>> scrapeSingleScene({
    required String scraperId,
    String? sceneId,
    String? query,
  });
  Future<void> updateScene(dynamic updates);
}
