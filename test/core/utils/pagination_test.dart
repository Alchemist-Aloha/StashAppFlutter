import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:stash_app_flutter/core/utils/pagination.dart';

FixedScrollMetrics _metrics({
  required double maxScrollExtent,
  required double pixels,
  double viewportDimension = 600,
}) {
  return FixedScrollMetrics(
    minScrollExtent: 0,
    maxScrollExtent: maxScrollExtent,
    pixels: pixels,
    viewportDimension: viewportDimension,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 1,
  );
}

void main() {
  test('loads the next page with one viewport of runway', () {
    expect(
      shouldLoadNextPage(_metrics(maxScrollExtent: 2000, pixels: 799)),
      isFalse,
    );
    expect(
      shouldLoadNextPage(_metrics(maxScrollExtent: 2000, pixels: 1400)),
      isTrue,
    );
    expect(
      shouldLoadNextPage(_metrics(maxScrollExtent: 0, pixels: 0)),
      isFalse,
    );
  });
}
