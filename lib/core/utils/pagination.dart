import 'package:flutter/widgets.dart';

const int kDefaultPageSize = 40;

bool shouldLoadNextPage(ScrollMetrics metrics) {
  if (metrics.maxScrollExtent <= 0) return false;
  return metrics.extentAfter <= metrics.viewportDimension;
}
