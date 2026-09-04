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
        sortName: StringCriterion(value: 'sort'),
        parentCount: IntCriterion(value: 2),
      ),
    );

    final input = config.toSaveInput();

    expect(input['mode'], 'TAGS');
    expect(input['find_filter']['direction'], 'ASC');
    expect(input['object_filter']['favorite'], true);
    expect(input['object_filter']['sort_name']['value'], 'sort');
    expect(input['object_filter']['parent_count']['value']['value'], 2);
  });
}
