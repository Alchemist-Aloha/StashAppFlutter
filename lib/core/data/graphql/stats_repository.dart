import 'package:graphql/client.dart';
import 'package:stash_app_flutter/core/data/graphql/graphql_exception.dart';

class StatsResult {
  final int sceneCount;
  final double scenesSize;
  final double scenesDuration;
  final int imageCount;
  final double imagesSize;
  final int galleryCount;
  final int performerCount;
  final int studioCount;
  final int groupCount;
  final int tagCount;
  final int totalOCount;
  final double totalPlayDuration;
  final int totalPlayCount;
  final int scenesPlayed;

  StatsResult({
    required this.sceneCount,
    required this.scenesSize,
    required this.scenesDuration,
    required this.imageCount,
    required this.imagesSize,
    required this.galleryCount,
    required this.performerCount,
    required this.studioCount,
    required this.groupCount,
    required this.tagCount,
    required this.totalOCount,
    required this.totalPlayDuration,
    required this.totalPlayCount,
    required this.scenesPlayed,
  });

  factory StatsResult.fromJson(Map<String, dynamic> json) {
    int intValue(String key) => (json[key] as num?)?.toInt() ?? 0;
    double doubleValue(String key) => (json[key] as num?)?.toDouble() ?? 0;

    return StatsResult(
      sceneCount: intValue('scene_count'),
      scenesSize: doubleValue('scenes_size'),
      scenesDuration: doubleValue('scenes_duration'),
      imageCount: intValue('image_count'),
      imagesSize: doubleValue('images_size'),
      galleryCount: intValue('gallery_count'),
      performerCount: intValue('performer_count'),
      studioCount: intValue('studio_count'),
      groupCount: intValue('group_count'),
      tagCount: intValue('tag_count'),
      totalOCount: intValue('total_o_count'),
      totalPlayDuration: doubleValue('total_play_duration'),
      totalPlayCount: intValue('total_play_count'),
      scenesPlayed: intValue('scenes_played'),
    );
  }
}

class StatsRepository {
  final GraphQLClient client;

  StatsRepository(this.client);

  static const String getStatsQuery = r'''
    query GetStats {
      stats {
        scene_count
        scenes_size
        scenes_duration
        image_count
        images_size
        gallery_count
        performer_count
        studio_count
        group_count
        tag_count
        total_o_count
        total_play_duration
        total_play_count
        scenes_played
      }
    }
  ''';

  Future<StatsResult> getStats() async {
    final result = await client.query(
      QueryOptions(
        document: gql(getStatsQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    validateGraphQLResult(result);

    final data = result.data?['stats'];
    if (data == null) {
      throw Exception('Failed to fetch stats: data is null');
    }

    return StatsResult.fromJson(data as Map<String, dynamic>);
  }
}
