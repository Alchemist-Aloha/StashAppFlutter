import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/scenes/presentation/widgets/tiktok_scenes_view.dart';

void main() {
  group('FullScreenMode', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is false', () {
      final isFullScreen = container.read(fullScreenModeProvider);
      expect(isFullScreen, isFalse);
    });

    test('toggle changes state', () {
      final isFullScreenInitial = container.read(fullScreenModeProvider);
      expect(isFullScreenInitial, isFalse);

      container.read(fullScreenModeProvider.notifier).toggle();
      final isFullScreenAfterToggle = container.read(fullScreenModeProvider);
      expect(isFullScreenAfterToggle, isTrue);

      container.read(fullScreenModeProvider.notifier).toggle();
      final isFullScreenAfterSecondToggle = container.read(
        fullScreenModeProvider,
      );
      expect(isFullScreenAfterSecondToggle, isFalse);
    });

    test('set updates state to specific value', () {
      final isFullScreenInitial = container.read(fullScreenModeProvider);
      expect(isFullScreenInitial, isFalse);

      container.read(fullScreenModeProvider.notifier).set(true);
      final isFullScreenAfterSetTrue = container.read(fullScreenModeProvider);
      expect(isFullScreenAfterSetTrue, isTrue);

      container.read(fullScreenModeProvider.notifier).set(false);
      final isFullScreenAfterSetFalse = container.read(fullScreenModeProvider);
      expect(isFullScreenAfterSetFalse, isFalse);
    });
  });

  testWidgets('feed action chevron expands and collapses actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeedActionMenu(
            actions: [
              IconButton(
                key: const Key('sort_action'),
                onPressed: () {},
                icon: const Icon(Icons.sort),
              ),
              IconButton(
                key: const Key('filter_action'),
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
              ),
              IconButton(
                key: const Key('preset_action'),
                onPressed: () {},
                icon: const Icon(Icons.bookmarks_outlined),
              ),
              IconButton(
                key: const Key('marker_action'),
                onPressed: () {},
                icon: const Icon(Icons.sell_outlined),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('sort_action')), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_up_rounded), findsOneWidget);

    await tester.tap(find.byKey(const Key('feed_actions_toggle')));
    await tester.pump();

    expect(find.byKey(const Key('sort_action')), findsOneWidget);
    expect(find.byKey(const Key('filter_action')), findsOneWidget);
    expect(find.byKey(const Key('preset_action')), findsOneWidget);
    expect(find.byKey(const Key('marker_action')), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);

    await tester.tap(find.byKey(const Key('feed_actions_toggle')));
    await tester.pump();

    expect(find.byKey(const Key('sort_action')), findsNothing);
  });
}
