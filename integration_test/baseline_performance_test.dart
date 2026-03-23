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
    // (which uses path_provider) succeeds in the VM. On device this is not
    // strictly necessary, but harmless.
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

    final stopwatch = Stopwatch()..start();
    await app.main(); // Ensure initialization completes
    await tester.pumpAndSettle();

    // Measure L1: Cold Launch Time
    stopwatch.stop();
    debugPrint('BENCHMARK: L1 Cold Launch = ${stopwatch.elapsedMilliseconds}ms');
  });
}
