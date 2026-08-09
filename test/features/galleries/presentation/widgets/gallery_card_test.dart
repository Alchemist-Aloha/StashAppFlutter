import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:stash_app_flutter/features/galleries/domain/entities/gallery.dart';
import 'package:stash_app_flutter/features/galleries/presentation/widgets/gallery_card.dart';
import 'package:stash_app_flutter/core/presentation/widgets/studio_performer_info_sections.dart';
import 'package:stash_app_flutter/features/scenes/presentation/widgets/scene_card.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  testWidgets('card opens gallery details by default', (tester) async {
    const gallery = Gallery(id: 'gallery-1', title: 'Gallery title');

    await pumpTestWidget(
      tester,
      child: const Scaffold(
        body: GalleryCard(gallery: gallery, thumbnailUrl: ''),
      ),
      routes: [
        GoRoute(
          path: '/galleries/gallery/:id',
          builder: (context, state) =>
              Text('details ${state.pathParameters['id']}'),
        ),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(GalleryCard));
    await tester.pumpAndSettle();

    expect(find.text('details gallery-1'), findsOneWidget);
  });

  testWidgets('grid card matches scene metadata and overflow layout', (
    tester,
  ) async {
    const gallery = Gallery(
      id: 'gallery-1',
      title: 'Gallery title',
      details: 'Details should not replace the studio',
      studioId: 'studio-1',
      studioName: 'Studio One',
      performerIds: ['performer-1'],
      performerNames: ['Performer One'],
      performerImagePaths: [null],
    );

    await pumpTestWidget(
      tester,
      child: const Scaffold(
        body: SizedBox(
          width: 320,
          child: GalleryCard(gallery: gallery, isGrid: true, thumbnailUrl: ''),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Studio One'), findsOneWidget);
    expect(find.text('Details should not replace the studio'), findsNothing);
    expect(find.byType(ScenePerformerAvatarRow), findsOneWidget);
    expect(find.byTooltip('Performer One'), findsOneWidget);

    final moreIcon = tester.widget<Icon>(find.byIcon(Icons.more_vert));
    expect(moreIcon.size, 16);
    final buttonBox = tester.widget<SizedBox>(
      find
          .ancestor(
            of: find.byIcon(Icons.more_vert),
            matching: find.byType(SizedBox),
          )
          .first,
    );
    expect(buttonBox.width, 32);
    expect(buttonBox.height, 32);

    await tester.longPress(find.byType(GalleryCard));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    final credits = find.byType(StudioPerformerInfoSections);
    expect(credits, findsOneWidget);
    expect(
      find.descendant(of: credits, matching: find.text('Studio One')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: credits, matching: find.text('Performer One')),
      findsOneWidget,
    );
  });
}
