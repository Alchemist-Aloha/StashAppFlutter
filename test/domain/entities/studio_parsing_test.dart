import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/studios/domain/entities/studio.dart';

void main() {
  group('Studio Entity Parsing', () {
    test('should parse studio from valid JSON', () {
      final json = {
        'id': 's1',
        'name': 'Studio One',
        'url': 'https://studio.example',
        'image_path': 'https://studio.example/logo.jpg',
        'details': 'Studio details',
        'rating100': 88,
        'scene_count': 100,
        'image_count': 40,
        'gallery_count': 7,
        'performer_count': 25,
        'scene_count_all': 120,
        'parent_studio': {'id': 'parent-1', 'name': 'Parent Studio'},
        'child_studios': [
          {'id': 'child-1', 'name': 'Child Studio'},
        ],
        'tags': [
          {'id': 'tag-1', 'name': 'Tag One'},
        ],
        'favorite': true,
      };

      final studio = Studio.fromJson(json);

      expect(studio.id, 's1');
      expect(studio.name, 'Studio One');
      expect(studio.sceneCount, 100);
      expect(studio.favorite, isTrue);
      expect(studio.sceneCountAll, 120);
      expect(studio.parentStudio?.name, 'Parent Studio');
      expect(studio.childStudios.single.name, 'Child Studio');
      expect(studio.tags.single.name, 'Tag One');
    });
  });
}
