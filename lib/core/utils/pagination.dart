import 'package:flutter/widgets.dart';

const int kDefaultPageSize = 40;
const double kPaginationLoadMoreThreshold = 200;

bool shouldLoadNextPage(
  ScrollMetrics metrics, {
  double threshold = kPaginationLoadMoreThreshold,
}) {
  if (metrics.maxScrollExtent <= 0) return false;
  return metrics.pixels >= metrics.maxScrollExtent - threshold;
}
