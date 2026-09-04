import '../../../../core/domain/entities/saved_filter_config.dart';
import 'performer_filter.dart';

class PerformerSavedFilterConfig extends SavedFilterConfig<PerformerFilter> {
  const PerformerSavedFilterConfig({
    super.id,
    required super.name,
    required super.searchQuery,
    required super.sort,
    required super.descending,
    required super.filter,
    super.perPage,
  }) : super(filterMode: 'PERFORMERS');

  factory PerformerSavedFilterConfig.fromServerPayload({
    required String id,
    required String name,
    Object? findFilter,
    Object? objectFilter,
  }) {
    final payload = savedFilterReadPayload(
      findFilter: findFilter,
      objectFilter: objectFilter,
      emptyFilter: PerformerFilter.empty(),
      fromJson: PerformerFilter.fromJson,
      serverToLocalKeys: _serverToLocalKeys,
      criterionTypes: _criterionTypes,
    );

    return PerformerSavedFilterConfig(
      id: id,
      name: name,
      searchQuery: payload.searchQuery,
      sort: payload.sort,
      descending: payload.descending,
      perPage: payload.perPage,
      filter: payload.filter,
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
    'favorite': 'filter_favorites',
    'isMissing': 'is_missing',
    'tagCount': 'tag_count',
    'sceneCount': 'scene_count',
    'imageCount': 'image_count',
    'galleryCount': 'gallery_count',
    'playCount': 'play_count',
    'oCounter': 'o_counter',
    'ignoreAutoTag': 'ignore_auto_tag',
    'heightCm': 'height_cm',
    'birthYear': 'birth_year',
    'deathYear': 'death_year',
    'penisLength': 'penis_length',
    'hairColor': 'hair_color',
    'eyeColor': 'eye_color',
    'fakeTits': 'fake_tits',
    'deathDate': 'death_date',
    'careerStart': 'career_start',
    'careerEnd': 'career_end',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'stashIdEndpoint': 'stash_id_endpoint',
    'customFields': 'custom_fields',
  };

  static final _serverToLocalKeys = {
    for (final entry in _localToServerKeys.entries) entry.value: entry.key,
  };

  static const _criterionTypes = {
    'favorite': SavedFilterCriterionType.boolean,
    'ignoreAutoTag': SavedFilterCriterionType.boolean,
    'isMissing': SavedFilterCriterionType.stringValue,
    'tags': SavedFilterCriterionType.hierarchical,
    'groups': SavedFilterCriterionType.hierarchical,
    'studios': SavedFilterCriterionType.hierarchical,
    'stashIdEndpoint': SavedFilterCriterionType.stashId,
    'customFields': SavedFilterCriterionType.customFields,
  };
}
