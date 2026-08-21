import 'package:flutter_test/flutter_test.dart';
import 'package:stash_app_flutter/features/setup/presentation/providers/update_provider.dart';

void main() {
  test('resolves versioned, RC, and nightly APK names by ABI', () {
    for (final label in ['1.29.0', 'rc', 'nightly']) {
      final url = 'https://example.test/StashFlow-$label-android-arm64-v8a.apk';
      expect(
        resolveAndroidApkUrlForAbi([
          {'name': url.split('/').last, 'browser_download_url': url},
        ], 'arm64-v8a'),
        url,
      );
    }
  });
}
