import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/scraper.dart';
import '../providers/scene_list_provider.dart';
import '../providers/scene_details_provider.dart';
import '../../../../core/data/graphql/schema.graphql.dart';

part 'scene_scrape_provider.g.dart';

@riverpod
class SceneScrape extends _$SceneScrape {
  @override
  FutureOr<List<Scraper>> build() async {
    final repository = ref.watch(sceneRepositoryProvider);
    return repository.listSceneScrapers();
  }

  Future<List<ScrapedScene>> scrapeScene({
    required Scraper scraper,
    required String sceneId,
  }) async {
    final repository = ref.read(sceneRepositoryProvider);

    String? query;
    String? id = sceneId;

    // If scraper doesn't support FRAGMENT (identifying by existing metadata/fingerprints),
    // we must use NAME (identifying by query string).
    if (!scraper.supportedScrapes.contains('FRAGMENT')) {
      final scene = await ref.read(sceneDetailsProvider(sceneId).future);
      query = scene.title;
      id = null; // Don't send sceneId if we want a NAME scrape
    }

    return repository.scrapeSingleScene(
      scraperId: scraper.id,
      sceneId: id,
      query: query,
    );
  }

  Future<void> updateScene({
    required String sceneId,
    required String title,
    required String date,
    required String details,
    required String? studioId,
    required List<String> performerIds,
    required List<String> tagIds,
  }) async {
    final repository = ref.read(sceneRepositoryProvider);
    await repository.updateScene(
      Input$SceneUpdateInput(
        id: sceneId,
        title: title,
        date: date,
        details: details,
        studio_id: studioId,
        performer_ids: performerIds,
        tag_ids: tagIds,
      ),
    );
    // Invalidate scene details so it re-fetches the updated info.
    // ref.invalidate(sceneDetailsProvider(sceneId)); 
    // Wait, sceneDetailsProvider might be auto-generated too.
  }
}
