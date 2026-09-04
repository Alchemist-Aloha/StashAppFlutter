import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';
import 'package:stash_app_flutter/features/images/domain/entities/image_filter.dart';
import 'package:stash_app_flutter/features/images/domain/entities/image_saved_filter_config.dart';

void main() {
  test('ImageSavedFilterConfig keeps organized state in object_filter', () {
    final config = ImageSavedFilterConfig(
      name: 'Organized images',
      searchQuery: 'cover',
      sort: 'path',
      descending: false,
      filter: const ImageFilter(
        organized: true,
        performerCount: IntCriterion(value: 2),
        studios: HierarchicalMultiCriterion(value: ['studio-1']),
        galleries: MultiCriterion(value: ['gallery-1']),
        code: StringCriterion(value: 'IMG-1'),
        photographer: StringCriterion(value: 'Alice'),
        phashDistance: PhashCriterion(value: 'abc', distance: 3),
        folder: HierarchicalMultiCriterion(value: ['folder-1']),
        isMissing: 'rating',
        customFields: [
          CustomFieldCriterion(field: 'source', value: ['archive']),
        ],
      ),
    );

    final input = config.toSaveInput();

    expect(input['mode'], 'IMAGES');
    expect(input['object_filter']['organized']['value'], 'true');
    expect(input['object_filter']['performer_count']['value']['value'], 2);
    expect(input['object_filter']['studios']['value']['items'], [
      {'id': 'studio-1', 'label': 'studio-1'},
    ]);
    expect(input['object_filter']['galleries']['value'], [
      {'id': 'gallery-1', 'label': 'gallery-1'},
    ]);
    expect(input['object_filter']['code']['value'], 'IMG-1');
    expect(input['object_filter']['photographer']['value'], 'Alice');
    expect(input['object_filter']['phash_distance']['value']['distance'], 3);
    expect(input['object_filter']['folder']['value']['items'], [
      {'id': 'folder-1', 'label': 'folder-1'},
    ]);
    expect(input['object_filter']['is_missing']['value'], 'rating');
    expect(input['object_filter']['custom_fields'].single['field'], 'source');

    final loaded = ImageSavedFilterConfig.fromServerPayload(
      id: '1',
      name: 'Organized images',
      objectFilter: input['object_filter'],
    );
    expect(loaded.filter.organized, isTrue);
    expect(loaded.filter.studios?.value, ['studio-1']);
    expect(loaded.filter.galleries?.value, ['gallery-1']);
    expect(loaded.filter.phashDistance?.distance, 3);
    expect(loaded.filter.folder?.value, ['folder-1']);
    expect(loaded.filter.isMissing, 'rating');
    expect(loaded.filter.customFields.single.field, 'source');
  });
}
