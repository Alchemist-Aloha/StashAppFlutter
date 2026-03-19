import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/tags/domain/entities/tag.dart';

void main() {
  group('Tag Entity Parsing', () {
    test('should parse tag from valid JSON', () {
      final json = {
        'id': 't1',
        'name': 'Tag One',
        'description': 'Tag details',
        'image_path': 'https://tags.example/tag.jpg',
        'scene_count': 55,
        'image_count': 12,
        'gallery_count': 8,
        'performer_count': 4,
        'favorite': false,
      };

      final tag = Tag.fromJson(json);

      expect(tag.id, 't1');
      expect(tag.name, 'Tag One');
      expect(tag.imageCount, 12);
      expect(tag.favorite, isFalse);
    });
  });
}
