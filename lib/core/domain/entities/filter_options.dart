enum OrganizedFilter {
  all,
  organized,
  unorganized;

  bool? toBool() => switch (this) {
    OrganizedFilter.all => null,
    OrganizedFilter.organized => true,
    OrganizedFilter.unorganized => false,
  };

  static OrganizedFilter fromBool(bool? value) {
    if (value == null) return OrganizedFilter.all;
    return value ? OrganizedFilter.organized : OrganizedFilter.unorganized;
  }
}

int activeFilterCount(Map<String, dynamic> filterJson) =>
    filterJson.values.where((value) {
      if (value == null) return false;
      if (value is Iterable) return value.isNotEmpty;
      if (value is Map) return value.isNotEmpty;
      return true;
    }).length;
