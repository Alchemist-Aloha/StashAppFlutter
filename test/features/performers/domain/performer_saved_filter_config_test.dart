import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';
import 'package:stash_app_flutter/features/performers/domain/entities/performer_filter.dart';
import 'package:stash_app_flutter/features/performers/domain/entities/performer_saved_filter_config.dart';

void main() {
  test(
    'PerformerSavedFilterConfig saves performer mode and filter payload',
    () {
      final config = PerformerSavedFilterConfig(
        name: 'Favorites',
        searchQuery: 'alice',
        sort: 'rating',
        descending: true,
        filter: const PerformerFilter(
          favorite: true,
          rating100: IntCriterion(value: 80),
          tags: HierarchicalMultiCriterion(
            value: ['tag-1'],
            excludes: ['tag-2'],
            depth: 1,
          ),
        ),
      );

      final input = config.toSaveInput();

      expect(input['mode'], 'PERFORMERS');
      expect(input['find_filter']['q'], 'alice');
      expect(input['find_filter']['sort'], 'rating');
      expect(input['find_filter']['direction'], 'DESC');
      expect(input['object_filter']['filter_favorites'], {
        'value': 'true',
        'modifier': 'EQUALS',
      });
      expect(input['object_filter']['rating100']['value']['value'], 80);
      expect(input['object_filter']['tags']['value'], {
        'items': [
          {'id': 'tag-1', 'label': 'tag-1'},
        ],
        'excluded': [
          {'id': 'tag-2', 'label': 'tag-2'},
        ],
        'depth': 1,
      });

      final loaded = PerformerSavedFilterConfig.fromServerPayload(
        id: '1',
        name: 'Favorites',
        objectFilter: input['object_filter'],
      );
      expect(loaded.filter.favorite, isTrue);
      expect(loaded.filter.tags?.value, ['tag-1']);
      expect(loaded.filter.tags?.excludes, ['tag-2']);
      expect(loaded.filter.tags?.depth, 1);
    },
  );
}
