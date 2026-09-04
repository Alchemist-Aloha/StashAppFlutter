import '../../../../core/domain/entities/saved_filter_config.dart';
import 'scene_filter.dart';

class SceneSavedFilterConfig extends SavedFilterConfig<SceneFilter> {
  const SceneSavedFilterConfig({
    super.id,
    required super.name,
    required super.searchQuery,
    required super.sort,
    required super.descending,
    required super.filter,
    super.perPage,
  }) : super(filterMode: 'SCENES');

  factory SceneSavedFilterConfig.fromServerPayload({
    required String id,
    required String name,
    Object? findFilter,
    Object? objectFilter,
  }) {
    final payload = savedFilterReadPayload(
      findFilter: findFilter,
      objectFilter: objectFilter,
      emptyFilter: SceneFilter.empty(),
      fromJson: SceneFilter.fromJson,
      serverToLocalKeys: _serverToLocalKeys,
      criterionTypes: _criterionTypes,
    );

    return SceneSavedFilterConfig(
      id: id,
      name: name,
      searchQuery: payload.searchQuery,
      sort: payload.sort,
      descending: payload.descending,
      perPage: payload.perPage,
      filter: payload.filter,
    );
  }

  factory SceneSavedFilterConfig.fromRaw(Map<String, dynamic> raw) {
    return SceneSavedFilterConfig.fromServerPayload(
      id: raw['id'] as String,
      name: raw['name'] as String,
      findFilter: raw['find_filter'],
      objectFilter: raw['object_filter'],
    );
  }

  @override
  Map<String, dynamic> toSaveInput() {
    return savedFilterBuildInput(
      id: id,
      mode: filterMode,
      name: name,
      searchQuery: searchQuery,
      sort: sort,
      descending: descending,
      perPage: perPage,
      objectFilter: savedFilterToServerObjectFilter(
        localJson: filter.toJson(),
        localToServerKeys: _localToServerKeys,
        criterionTypes: _criterionTypes,
      ),
    );
  }

  static const _localToServerKeys = {
    'oCounter': 'o_counter',
    'lastPlayedAt': 'last_played_at',
    'productionDate': 'production_date',
    'interactiveSpeed': 'interactive_speed',
    'performerAge': 'performer_age',
    'videoCodec': 'video_codec',
    'audioCodec': 'audio_codec',
    'hasMarkers': 'has_markers',
    'isMissing': 'is_missing',
    'fileCount': 'file_count',
    'playCount': 'play_count',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'phashDistance': 'phash_distance',
    'resumeTime': 'resume_time',
    'playDuration': 'play_duration',
    'tagCount': 'tag_count',
    'performerCount': 'performer_count',
    'stashIdCount': 'stash_id_count',
    'stashIdEndpoint': 'stash_id_endpoint',
    'performerTags': 'performer_tags',
    'performerFavorite': 'performer_favorite',
    'customFields': 'custom_fields',
    'resolutions': 'resolution',
    'orientations': 'orientation',
  };

  static final _serverToLocalKeys = {
    for (final entry in _localToServerKeys.entries) entry.value: entry.key,
  };

  static const _criterionTypes = {
    'organized': SavedFilterCriterionType.boolean,
    'interactive': SavedFilterCriterionType.boolean,
    'hasMarkers': SavedFilterCriterionType.boolean,
    'performerFavorite': SavedFilterCriterionType.boolean,
    'isMissing': SavedFilterCriterionType.stringValue,
    'folder': SavedFilterCriterionType.hierarchical,
    'studios': SavedFilterCriterionType.hierarchical,
    'performers': SavedFilterCriterionType.labeledWithExclusions,
    'tags': SavedFilterCriterionType.hierarchical,
    'groups': SavedFilterCriterionType.hierarchical,
    'galleries': SavedFilterCriterionType.labeled,
    'performerTags': SavedFilterCriterionType.hierarchical,
    'phashDistance': SavedFilterCriterionType.phash,
    'duplicated': SavedFilterCriterionType.duplication,
    'stashIdEndpoint': SavedFilterCriterionType.stashId,
    'customFields': SavedFilterCriterionType.customFields,
  };
}
