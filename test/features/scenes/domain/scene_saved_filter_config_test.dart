import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';
import 'package:stash_app_flutter/features/scenes/domain/entities/scene_filter.dart';
import 'package:stash_app_flutter/features/scenes/domain/entities/scene_saved_filter_config.dart';

void main() {
  group('SceneSavedFilterConfig', () {
    test('builds server input from current search, sort, and scene filter', () {
      final config = SceneSavedFilterConfig(
        name: 'Favorites',
        searchQuery: 'studio search',
        sort: 'rating',
        descending: true,
        filter: const SceneFilter(
          rating100: IntCriterion(
            value: 80,
            modifier: CriterionModifier.greaterThan,
          ),
          tags: HierarchicalMultiCriterion(value: ['7', '9']),
          organized: true,
          oCounter: IntCriterion(value: 2),
        ),
        perPage: 60,
      );

      final input = config.toSaveInput();

      expect(input['name'], 'Favorites');
      expect(input['mode'], 'SCENES');
      expect(input['find_filter']['q'], 'studio search');
      expect(input['find_filter']['sort'], 'rating');
      expect(input['find_filter']['direction'], 'DESC');
      expect(input['find_filter']['per_page'], 60);
      expect(input['object_filter']['rating100'], {
        'value': {'value': 80},
        'modifier': 'GREATER_THAN',
      });
      expect(input['object_filter'], contains('tags'));
      expect(input['object_filter']['organized'], true);
      expect(input['object_filter']['o_counter'], {
        'value': {'value': 2},
        'modifier': 'EQUALS',
      });
      expect(input['object_filter'], isNot(contains('oCounter')));
      expect(input['ui_options'], isA<Map<String, dynamic>>());
    });

    test('loads official Stash scene filter and sort from server payload', () {
      final config = SceneSavedFilterConfig.fromServerPayload(
        id: '12',
        name: 'Recent landscape',
        findFilter: {
          'q': 'landscape',
          'sort': 'date',
          'direction': 'ASC',
          'per_page': 45,
        },
        objectFilter: {
          'organized': false,
          'path': {'value': '/media', 'modifier': 'INCLUDES'},
          'o_counter': {
            'value': {'value': 4},
            'modifier': 'GREATER_THAN',
          },
          'last_played_at': {
            'value': {'value': '2025-01-01'},
            'modifier': 'NOT_NULL',
          },
          'performers': {
            'value': ['3'],
            'modifier': 'INCLUDES',
          },
        },
      );

      expect(config.id, '12');
      expect(config.name, 'Recent landscape');
      expect(config.searchQuery, 'landscape');
      expect(config.sort, 'date');
      expect(config.descending, false);
      expect(config.perPage, 45);
      expect(config.filter.organized, false);
      expect(config.filter.path?.value, '/media');
      expect(config.filter.oCounter?.value, 4);
      expect(config.filter.lastPlayedAt?.value, '2025-01-01');
      expect(config.filter.performers?.value, ['3']);
    });

    test('loads official Stash numeric ranges and null criteria', () {
      final config = SceneSavedFilterConfig.fromServerPayload(
        id: '15',
        name: 'Numeric ranges',
        objectFilter: {
          'duration': {
            'value': {'value': 60, 'value2': 120},
            'modifier': 'BETWEEN',
          },
          'rating100': {'value': <String, dynamic>{}, 'modifier': 'NOT_NULL'},
        },
      );

      expect(
        config.filter.duration,
        const IntCriterion(
          value: 60,
          value2: 120,
          modifier: CriterionModifier.between,
        ),
      );
      expect(
        config.filter.rating100,
        const IntCriterion(value: 0, modifier: CriterionModifier.notNull),
      );
    });

    test('normalizes official boolean criterion maps without crashing', () {
      final config = SceneSavedFilterConfig.fromServerPayload(
        id: '13',
        name: 'Boolean criteria',
        objectFilter: {
          'organized': {'value': 'true', 'modifier': 'EQUALS'},
          'interactive': {'value': 'false', 'modifier': 'EQUALS'},
          'has_markers': {'value': 'true', 'modifier': 'EQUALS'},
          'is_missing': {'value': 'title', 'modifier': 'EQUALS'},
        },
      );

      expect(config.filter.organized, true);
      expect(config.filter.interactive, false);
      expect(config.filter.hasMarkers, true);
      expect(config.filter.isMissing, isNull);
    });

    test('normalizes single-value multi criteria from server payload', () {
      final config = SceneSavedFilterConfig.fromServerPayload(
        id: '14',
        name: 'Single tag',
        objectFilter: {
          'tags': {'value': '7', 'modifier': 'INCLUDES'},
          'performers': {'value': 9, 'modifier': 'INCLUDES'},
        },
      );

      expect(config.filter.tags?.value, ['7']);
      expect(config.filter.performers?.value, ['9']);
    });
  });
}
