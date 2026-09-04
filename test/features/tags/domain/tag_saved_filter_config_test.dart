import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/tags/domain/entities/tag_saved_filter_config.dart';
import 'package:stash_app_flutter/features/tags/domain/entities/tag_filter.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';

void main() {
  test('TagSavedFilterConfig stores favorites-only as server favorite', () {
    final config = TagSavedFilterConfig(
      name: 'Favorite tags',
      searchQuery: 'fav',
      sort: 'name',
      descending: false,
      filter: const TagFilter(
        favorite: true,
        ignoreAutoTag: false,
        isMissingField: 'description',
        sortName: StringCriterion(value: 'sort'),
        parentCount: IntCriterion(value: 2),
        parents: HierarchicalMultiCriterion(value: ['parent-1']),
      ),
    );

    final input = config.toSaveInput();

    expect(input['mode'], 'TAGS');
    expect(input['find_filter']['direction'], 'ASC');
    expect(input['object_filter']['favorite']['value'], 'true');
    expect(input['object_filter']['ignore_auto_tag']['value'], 'false');
    expect(input['object_filter']['is_missing']['value'], 'description');
    expect(input['object_filter']['sort_name']['value'], 'sort');
    expect(input['object_filter']['parent_count']['value']['value'], 2);
    expect(input['object_filter']['parents']['value']['items'], [
      {'id': 'parent-1', 'label': 'parent-1'},
    ]);

    final loaded = TagSavedFilterConfig.fromServerPayload(
      id: '1',
      name: 'Favorite tags',
      objectFilter: input['object_filter'],
    );
    expect(loaded.filter.favorite, isTrue);
    expect(loaded.filter.ignoreAutoTag, isFalse);
    expect(loaded.filter.isMissingField, 'description');
    expect(loaded.filter.parents?.value, ['parent-1']);
  });
}
