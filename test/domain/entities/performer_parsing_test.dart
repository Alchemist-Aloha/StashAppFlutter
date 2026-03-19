import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/performers/domain/entities/performer.dart';

void main() {
  group('Performer Entity Parsing', () {
    test('should parse performer from valid JSON', () {
      final json = {
        'id': 'p1',
        'name': 'Performer One',
        'disambiguation': 'aka P1',
        'urls': ['https://example.com'],
        'gender': 'FEMALE',
        'birthdate': '1990-01-01',
        'ethnicity': 'Test',
        'country': 'US',
        'eye_color': 'Brown',
        'height_cm': 170,
        'measurements': '34-24-34',
        'fake_tits': 'No',
        'penis_length': null,
        'circumcised': null,
        'career_start': '2010',
        'career_end': null,
        'tattoos': 'None',
        'piercings': 'Ears',
        'alias_list': ['Alias One'],
        'favorite': false,
        'image_path': 'https://example.com/image.jpg',
        'scene_count': 42,
        'image_count': 10,
        'gallery_count': 2,
        'group_count': 1,
        'rating100': 90,
        'details': 'Test details',
        'death_date': null,
        'hair_color': 'Black',
        'weight': 55,
        'tag_ids': ['t1'],
        'tag_names': ['Tag One'],
      };

      final performer = Performer.fromJson(json);

      expect(performer.id, 'p1');
      expect(performer.name, 'Performer One');
      expect(performer.heightCm, 170);
      expect(performer.tagNames, ['Tag One']);
    });
  });
}
