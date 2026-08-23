import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('strip prefetch is lifecycle-safe and not scheduled by build', () {
    const paths = [
      'lib/features/galleries/presentation/widgets/gallery_strip.dart',
      'lib/features/scenes/presentation/widgets/scene_strip.dart',
    ];

    for (final path in paths) {
      final source = File(path).readAsStringSync();
      expect(
        source,
        contains(
          'WidgetsBinding.instance.addPostFrameCallback((_) {\n'
          '      if (!mounted) return;',
        ),
        reason: path,
      );
      expect(source, contains('int _lastVisibleIndex = -1;'), reason: path);
      expect(
        source.indexOf('addPostFrameCallback'),
        lessThan(source.indexOf('Widget build(BuildContext context)')),
        reason: path,
      );
    }
  });
}
