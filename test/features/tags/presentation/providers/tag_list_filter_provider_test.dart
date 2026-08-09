import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_app_flutter/core/data/preferences/shared_preferences_provider.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';
import 'package:stash_app_flutter/features/tags/domain/entities/tag_filter.dart';
import 'package:stash_app_flutter/features/tags/presentation/providers/tag_list_provider.dart';

void main() {
  test('migrates and persists the expanded tag filter', () async {
    SharedPreferences.setMockInitialValues({'tag_favorites_only': true});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    expect(container.read(tagListFilterProvider).favorite, isTrue);

    container
        .read(tagListFilterProvider.notifier)
        .set(
          const TagFilter(
            name: StringCriterion(value: 'tag'),
            parentCount: IntCriterion(value: 2),
          ),
        );
    await container.read(tagListFilterProvider.notifier).saveAsDefault();

    expect(prefs.getString('tag_filter_state'), contains('parentCount'));
    expect(prefs.getBool('tag_favorites_only'), isFalse);
  });
}
