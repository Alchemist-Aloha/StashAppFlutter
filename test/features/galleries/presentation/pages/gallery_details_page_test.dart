import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/galleries/domain/entities/gallery.dart';
import 'package:stash_app_flutter/features/galleries/presentation/pages/gallery_details_page.dart';
import 'package:stash_app_flutter/features/galleries/presentation/providers/gallery_details_provider.dart';
import 'package:stash_app_flutter/features/images/domain/entities/image.dart'
    as entity;
import 'package:stash_app_flutter/features/images/presentation/providers/image_list_provider.dart';
import 'package:stash_app_flutter/features/images/presentation/widgets/image_card.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  testWidgets('gallery details browses images and collapses while scrolling', (
    tester,
  ) async {
    const gallery = Gallery(
      id: 'gallery-1',
      title: 'Gallery One',
      details: 'Compact gallery description',
      date: '2026-08-09',
      imageCount: 30,
      studioId: 'studio-1',
      studioName: 'Studio One',
      performerIds: ['performer-1'],
      performerNames: ['Performer One'],
    );
    final repository = MockGraphQLImageRepository()
      ..withData(
        List.generate(
          30,
          (index) => entity.Image(
            id: 'image-$index',
            title: 'Image $index',
            files: const [entity.ImageFile(width: 100, height: 100, path: '')],
            paths: const entity.ImagePaths(image: '', thumbnail: ''),
          ),
        ),
      );

    await pumpTestWidget(
      tester,
      overrides: [
        galleryDetailsProvider('gallery-1').overrideWith((ref) => gallery),
        imageRepositoryProvider.overrideWithValue(repository),
      ],
      child: const GalleryDetailsPage(galleryId: 'gallery-1'),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('gallery_details_expanded')), findsOneWidget);
    expect(find.text('Compact gallery description'), findsOneWidget);
    expect(find.text('Studio One'), findsOneWidget);
    expect(find.text('Performer One'), findsOneWidget);
    expect(find.byIcon(Icons.sort), findsOneWidget);
    expect(find.byIcon(Icons.filter_list), findsOneWidget);
    expect(find.byIcon(Icons.bookmarks_outlined), findsOneWidget);
    expect(repository.findImageCalls.last.galleryId, 'gallery-1');

    await tester.drag(find.byType(ImageCard).first, const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('gallery_details_collapsed')), findsOneWidget);

    final scrollPosition = Scrollable.of(
      tester.element(find.byType(ImageCard).first),
    ).position;
    final offsetBeforeExpand = scrollPosition.pixels;

    await tester.tap(find.byIcon(Icons.expand_more_rounded));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('gallery_details_expanded')), findsOneWidget);
    expect(scrollPosition.pixels, offsetBeforeExpand);
  });
}
