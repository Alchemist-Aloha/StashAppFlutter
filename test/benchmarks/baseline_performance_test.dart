import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stash_app_flutter/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Baseline Performance Benchmark', (tester) async {
    // Mock path_provider for the test environment so Hive initialization
    // (which uses path_provider) succeeds in the VM.
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    channel.setMockMethodCallHandler((MethodCall method) async {
      if (method.method == 'getApplicationDocumentsDirectory') {
        final dir = Directory.systemTemp.createTempSync('stash_test_docs');
        return dir.path;
      }
      if (method.method == 'getTemporaryDirectory') {
        final dir = Directory.systemTemp.createTempSync('stash_test_temp');
        return dir.path;
      }
      if (method.method == 'getApplicationSupportDirectory') {
        final dir = Directory.systemTemp.createTempSync('stash_test_support');
        return dir.path;
      }
      return null;
    });
    // Provide mock shared preferences for the test environment.
    SharedPreferences.setMockInitialValues({});

    // Mock wakelock_plus platform channel to avoid platform errors in tests.
    // Pigeon's BasicMessageChannel for wakelock_plus; provide a mock handler
    // that returns a successful empty response.
    const wakelockChannelName =
        'dev.flutter.pigeon.wakelock_plus_platform_interface.WakelockPlusApi';
    final codec = StandardMessageCodec();
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      wakelockChannelName,
      (ByteData? message) async {
        return codec.encodeMessage(null);
      },
    );
    // Also mock possible variant channel names used internally.
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      '$wakelockChannelName.toggle',
      (ByteData? message) async {
        return codec.encodeMessage(null);
      },
    );
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      '$wakelockChannelName.isEnabled',
      (ByteData? message) async {
        return codec.encodeMessage(null);
      },
    );
    // Also set MethodChannel mock handlers for wakelock Pigeon channels.
    final wakelockMethod = MethodChannel(wakelockChannelName);
    wakelockMethod.setMockMethodCallHandler((MethodCall method) async {
      return null;
    });
    final wakelockToggleMethod = MethodChannel('$wakelockChannelName.toggle');
    wakelockToggleMethod.setMockMethodCallHandler((MethodCall method) async {
      return null;
    });

    final stopwatch = Stopwatch()..start();
    await app.main(); // Ensure initialization completes
    await tester.pumpAndSettle();

    // Measure L1: Cold Launch Time
    stopwatch.stop();
    debugPrint(
      'BENCHMARK: L1 Cold Launch = ${stopwatch.elapsedMilliseconds}ms',
    );

    // N1: Counting network requests
    // (Verification will be manual or through log counting in Task 7)

    // M1: Memory Usage
    // Capture using tester's binding if supported, or manual check in Task 7.
  });
}
