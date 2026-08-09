import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/galleries/domain/entities/gallery.dart';
import 'package:stash_app_flutter/features/galleries/presentation/pages/gallery_details_page.dart';
import 'package:stash_app_flutter/features/galleries/presentation/providers/gallery_details_provider.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  testWidgets('gallery details exposes relationship tabs and chapter data', (
    tester,
  ) async {
    const gallery = Gallery(
      id: 'gallery-1',
      title: 'Gallery One',
      imageCount: 2,
      chapters: [
        GalleryChapter(id: 'chapter-1', title: 'Opening', imageIndex: 3),
      ],
    );

    await pumpTestWidget(
      tester,
      overrides: [
        galleryDetailsProvider('gallery-1').overrideWith((ref) => gallery),
        galleryImagesProvider('gallery-1').overrideWith((ref) => []),
        galleryScenesProvider('gallery-1').overrideWith((ref) => []),
      ],
      child: const GalleryDetailsPage(galleryId: 'gallery-1'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Images (2)'), findsOneWidget);
    expect(find.text('Chapters (1)'), findsOneWidget);
    expect(find.text('Scenes'), findsOneWidget);

    await tester.tap(find.text('Chapters (1)'));
    await tester.pumpAndSettle();

    expect(find.text('Opening'), findsOneWidget);
    expect(find.text('Image 3'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_outline_rounded), findsOneWidget);
  });
}
