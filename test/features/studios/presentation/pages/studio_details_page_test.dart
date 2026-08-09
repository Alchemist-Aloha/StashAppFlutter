import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/galleries/presentation/providers/entity_gallery_filter_scope.dart';
import 'package:stash_app_flutter/features/scenes/presentation/providers/entity_media_filter_scope.dart';
import 'package:stash_app_flutter/features/studios/domain/entities/studio.dart';
import 'package:stash_app_flutter/features/studios/presentation/pages/studio_details_page.dart';
import 'package:stash_app_flutter/features/studios/presentation/providers/studio_details_provider.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  testWidgets('studio details exposes hierarchy and richer counts', (
    tester,
  ) async {
    const studio = Studio(
      id: 'studio-1',
      name: 'Studio One',
      sceneCount: 2,
      imageCount: 3,
      galleryCount: 1,
      performerCount: 4,
      sceneCountAll: 8,
      favorite: false,
      parentStudio: StudioRelationship(id: 'parent-1', name: 'Parent Studio'),
      childStudios: [StudioRelationship(id: 'child-1', name: 'Child Studio')],
    );

    await pumpTestWidget(
      tester,
      overrides: [
        studioDetailsProvider('studio-1').overrideWith((ref) => studio),
        entityMediaPreviewProvider(
          EntityMediaFilterKind.studio,
          'studio-1',
        ).overrideWith((ref) => []),
        entityGalleryPreviewProvider(
          EntityGalleryFilterKind.studio,
          'studio-1',
        ).overrideWith((ref) => []),
        studioImagesProvider('studio-1').overrideWith((ref) => []),
      ],
      child: const StudioDetailsPage(studioId: 'studio-1'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Scenes (2)'), findsOneWidget);
    expect(find.text('Galleries (1)'), findsOneWidget);
    expect(find.text('Images (3)'), findsOneWidget);
    expect(find.text('Hierarchy (1)'), findsOneWidget);
    expect(find.text('Scenes: 2 / 8'), findsOneWidget);

    await tester.tap(find.text('Hierarchy (1)'));
    await tester.pumpAndSettle();

    expect(find.text('Parent Studio'), findsOneWidget);
    expect(find.text('Child Studio'), findsOneWidget);
  });
}
