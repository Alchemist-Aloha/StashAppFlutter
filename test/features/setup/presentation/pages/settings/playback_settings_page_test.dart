import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_app_flutter/features/scenes/presentation/providers/video_player_provider.dart';
import 'package:stash_app_flutter/features/setup/presentation/pages/settings/playback_settings_page.dart';
import 'package:stash_app_flutter/features/setup/presentation/widgets/settings_page_shell.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({'video_gravity_orientation': true});
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets('PlaybackSettingsPage renders gravity orientation toggle', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await pumpTestWidget(
      tester,
      prefs: prefs,
      child: const PlaybackSettingsPage(),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPanelCard), findsWidgets);
    expect(find.text('Gravity-controlled orientation'), findsOneWidget);
    expect(
      find.textContaining('Allow rotating between matching orientations'),
      findsOneWidget,
    );

    // Find the switch that is part of the gravity orientation ListTile
    // We can use descendant search
    final gravitySwitch = find.descendant(
      of: find.ancestor(
        of: find.text('Gravity-controlled orientation'),
        matching: find.byType(SwitchListTile),
      ),
      matching: find.byType(Switch),
    );

    expect(tester.widget<Switch>(gravitySwitch).value, isTrue);

    await tester.tap(gravitySwitch);
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(gravitySwitch).value, isFalse);
    expect(prefs.getBool('video_gravity_orientation'), isFalse);
  });

  testWidgets('PlaybackSettingsPage omits the obsolete sceneStreams toggle', (
    tester,
  ) async {
    await pumpTestWidget(
      tester,
      prefs: prefs,
      child: const PlaybackSettingsPage(),
    );
    await tester.pumpAndSettle();

    expect(find.text('Prefer sceneStreams first'), findsNothing);
  });

  testWidgets('PlaybackSettingsPage omits the direct-play setting', (
    tester,
  ) async {
    await pumpTestWidget(
      tester,
      prefs: prefs,
      child: const PlaybackSettingsPage(),
    );
    await tester.pumpAndSettle();

    expect(find.text('Direct-play on scene navigation'), findsNothing);
  });

  testWidgets(
    'PlaybackSettingsPage defaults preferred fullscreen off and persists it',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await pumpTestWidget(
        tester,
        prefs: prefs,
        child: const PlaybackSettingsPage(),
      );
      await tester.pumpAndSettle();

      final title = find.text('Open scenes in fullscreen');
      expect(title, findsOneWidget);
      await tester.ensureVisible(title);
      final fullscreenSwitch = find.descendant(
        of: find.ancestor(of: title, matching: find.byType(SwitchListTile)),
        matching: find.byType(Switch),
      );

      expect(tester.widget<Switch>(fullscreenSwitch).value, isFalse);

      await tester.tap(fullscreenSwitch);
      await tester.pumpAndSettle();

      expect(tester.widget<Switch>(fullscreenSwitch).value, isTrue);
      expect(prefs.getBool('video_enter_fullscreen_on_navigation'), isTrue);
    },
  );

  testWidgets(
    'PlaybackSettingsPage renders feed random start position toggle and updates prefs',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await pumpTestWidget(
        tester,
        prefs: prefs,
        child: const PlaybackSettingsPage(),
      );
      await tester.pumpAndSettle();

      expect(find.text('Start Feed from random position'), findsOneWidget);
      expect(
        find.textContaining('start from a random position between 0% and 90%'),
        findsOneWidget,
      );

      final feedRandomSwitch = find.descendant(
        of: find.ancestor(
          of: find.text('Start Feed from random position'),
          matching: find.byType(SwitchListTile),
        ),
        matching: find.byType(Switch),
      );

      expect(tester.widget<Switch>(feedRandomSwitch).value, isFalse);

      await tester.tap(feedRandomSwitch);
      await tester.pumpAndSettle();

      expect(tester.widget<Switch>(feedRandomSwitch).value, isTrue);
      expect(prefs.getBool('feed_start_random'), isTrue);
    },
  );

  testWidgets('resume-position changes update the live player state', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await pumpTestWidget(
      tester,
      prefs: prefs,
      child: const PlaybackSettingsPage(),
    );
    await tester.pumpAndSettle();

    final title = find.text('Resume from last playing position');
    await tester.ensureVisible(title);
    final resumeSwitch = find.descendant(
      of: find.ancestor(of: title, matching: find.byType(SwitchListTile)),
      matching: find.byType(Switch),
    );
    final container = ProviderScope.containerOf(
      tester.element(find.byType(PlaybackSettingsPage)),
      listen: false,
    );

    expect(container.read(playerStateProvider).resumePlayPosition, isTrue);
    await tester.tap(resumeSwitch);
    await tester.pumpAndSettle();

    expect(prefs.getBool('video_resume_play_position'), isFalse);
    expect(container.read(playerStateProvider).resumePlayPosition, isFalse);
  });
}
