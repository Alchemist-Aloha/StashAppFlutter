import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/graphql/graphql_client.dart';
import '../../../../core/data/graphql/schema.graphql.dart';
import '../../../../core/data/graphql/url_resolver.dart';
import '../../../../core/data/preferences/shared_preferences_provider.dart';
import '../../../scenes/data/graphql/scenes.graphql.dart';

part 'studio_media_provider.g.dart';

class StudioMediaItem {
  const StudioMediaItem({
    required this.sceneId,
    required this.title,
    required this.thumbnailUrl,
  });

  final String sceneId;
  final String title;
  final String thumbnailUrl;
}

@riverpod
FutureOr<List<StudioMediaItem>> studioMedia(Ref ref, String studioId) async {
  final client = ref.watch(graphqlClientProvider);

  final result = await client.query$FindScenes(
    Options$Query$FindScenes(
      variables: Variables$Query$FindScenes(
        filter: Input$FindFilterType(page: 1, per_page: 24),
        scene_filter: Input$SceneFilterType(
          studios: Input$HierarchicalMultiCriterionInput(
            value: <String>[studioId],
            modifier: Enum$CriterionModifier.INCLUDES,
          ),
        ),
      ),
    ),
  );

  if (result.hasException) throw result.exception!;

  final prefs = ref.read(sharedPreferencesProvider);
  final storedServerUrl = prefs.getString('server_base_url')?.trim() ?? '';
  final normalizedServerUrl = normalizeGraphqlServerUrl(storedServerUrl);
  final endpoint = Uri.parse(
    normalizedServerUrl.isEmpty
        ? 'http://localhost:9999/graphql'
        : normalizedServerUrl,
  );

  return result.parsedData!.findScenes.scenes
      .map(
        (scene) => StudioMediaItem(
          sceneId: scene.id,
          title: scene.title ?? 'Untitled',
          thumbnailUrl: resolveGraphqlMediaUrl(
            rawUrl: scene.paths.screenshot ?? scene.paths.preview,
            graphqlEndpoint: endpoint,
          ),
        ),
      )
      .where((item) => item.thumbnailUrl.isNotEmpty)
      .toList();
}