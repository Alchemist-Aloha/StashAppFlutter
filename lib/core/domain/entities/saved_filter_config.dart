import 'dart:convert';

abstract class SavedFilterConfig<TFilter> {
  const SavedFilterConfig({
    this.id,
    required this.name,
    required this.filterMode,
    required this.searchQuery,
    required this.sort,
    required this.descending,
    required this.filter,
    this.perPage,
  });

  final String? id;
  final String name;
  final String filterMode;
  final String searchQuery;
  final String? sort;
  final bool descending;
  final TFilter filter;
  final int? perPage;

  Map<String, dynamic> toSaveInput();
}

class SavedFilterSkipValue {
  const SavedFilterSkipValue._();
}

const savedFilterSkipValue = SavedFilterSkipValue._();

/// Describes how official Stash persists a criterion's UI value.
enum SavedFilterCriterionType {
  boolean,
  stringValue,
  labeled,
  labeledWithExclusions,
  hierarchical,
  phash,
  stashId,
  customFields,
  duplication,
  skip,
}

class SavedFilterPayload<TFilter> {
  const SavedFilterPayload({
    required this.searchQuery,
    required this.sort,
    required this.descending,
    required this.filter,
    this.perPage,
  });

  final String searchQuery;
  final String? sort;
  final bool descending;
  final TFilter filter;
  final int? perPage;
}

SavedFilterPayload<TFilter> savedFilterReadPayload<TFilter>({
  required Object? findFilter,
  required Object? objectFilter,
  required TFilter emptyFilter,
  required TFilter Function(Map<String, dynamic> json) fromJson,
  Map<String, String> serverToLocalKeys = const {},
  Map<String, SavedFilterCriterionType> criterionTypes = const {},
}) {
  final findFilterMap = savedFilterAsMap(findFilter);
  final objectFilterMap = savedFilterAsMap(objectFilter);
  final direction = findFilterMap['direction'];

  return SavedFilterPayload(
    searchQuery: findFilterMap['q'] as String? ?? '',
    sort: findFilterMap['sort'] as String?,
    descending: direction is String ? direction.toUpperCase() == 'DESC' : true,
    perPage: findFilterMap['per_page'] as int?,
    filter: objectFilterMap.isEmpty
        ? emptyFilter
        : fromJson(
            savedFilterFromServerObjectFilter(
              objectFilter: objectFilterMap,
              serverToLocalKeys: serverToLocalKeys,
              criterionTypes: criterionTypes,
            ),
          ),
  );
}

Map<String, dynamic> savedFilterBuildInput({
  String? id,
  required String mode,
  required String name,
  required String searchQuery,
  required String? sort,
  required bool descending,
  required Map<String, dynamic> objectFilter,
  int? perPage,
}) {
  return {
    'id': ?id,
    'mode': mode,
    'name': name,
    'find_filter': {
      if (searchQuery.isNotEmpty) 'q': searchQuery,
      'page': 1,
      'per_page': ?perPage,
      'sort': ?sort,
      'direction': descending ? 'DESC' : 'ASC',
    },
    'object_filter': objectFilter,
    'ui_options': <String, Object?>{},
  };
}

Map<String, dynamic> savedFilterAsMap(Object? value) {
  if (value == null) return <String, dynamic>{};
  if (value is Map<String, dynamic>) return Map<String, dynamic>.from(value);
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  if (value is String && value.trim().isNotEmpty) {
    final decoded = jsonDecode(value);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
  }
  return <String, dynamic>{};
}

Map<String, dynamic> savedFilterWithoutNulls(Map<String, dynamic> value) {
  return {
    for (final entry in value.entries)
      if (entry.value != null &&
          (entry.value is! Iterable || (entry.value as Iterable).isNotEmpty) &&
          (entry.value is! Map || (entry.value as Map).isNotEmpty))
        entry.key: entry.value,
  };
}

Map<String, dynamic> savedFilterToServerObjectFilter({
  required Map<String, dynamic> localJson,
  Map<String, String> localToServerKeys = const {},
  Map<String, SavedFilterCriterionType> criterionTypes = const {},
}) {
  final compact = savedFilterWithoutNulls(localJson);
  final output = <String, dynamic>{};
  for (final entry in compact.entries) {
    final value = _toSavedCriterion(entry.value, criterionTypes[entry.key]);
    if (identical(value, savedFilterSkipValue)) continue;
    output[localToServerKeys[entry.key] ?? entry.key] = value;
  }
  return output;
}

Object? _toSavedCriterion(Object? value, SavedFilterCriterionType? type) {
  if (type == SavedFilterCriterionType.skip) return savedFilterSkipValue;
  if (type == SavedFilterCriterionType.boolean) {
    return {'value': value.toString(), 'modifier': 'EQUALS'};
  }
  if (type == SavedFilterCriterionType.stringValue) {
    return {'value': value, 'modifier': 'EQUALS'};
  }

  final criterion = savedFilterAsMap(value);
  if (type == SavedFilterCriterionType.labeled) {
    return {
      ..._savedCriterionMetadata(criterion),
      'value': _savedFilterLabels(criterion['value']),
    };
  }
  if (type == SavedFilterCriterionType.labeledWithExclusions) {
    return {
      ..._savedCriterionMetadata(criterion),
      'value': {
        'items': _savedFilterLabels(criterion['value']),
        'excluded': _savedFilterLabels(criterion['excludes']),
      },
    };
  }
  if (type == SavedFilterCriterionType.hierarchical) {
    return {
      ..._savedCriterionMetadata(criterion),
      'value': {
        'items': _savedFilterLabels(criterion['value']),
        'excluded': _savedFilterLabels(criterion['excludes']),
        'depth': criterion['depth'] as int? ?? 0,
      },
    };
  }
  if (type == SavedFilterCriterionType.phash) {
    return {
      ..._savedCriterionMetadata(criterion),
      'value': {
        'value': criterion['value'],
        if (criterion['distance'] != null) 'distance': criterion['distance'],
      },
    };
  }
  if (type == SavedFilterCriterionType.stashId) {
    return {
      ..._savedCriterionMetadata(criterion),
      'value': {
        'endpoint': criterion['endpoint'],
        'stashID': criterion['stashId'],
      },
    };
  }
  if (type == SavedFilterCriterionType.customFields) {
    final fields = value is List
        ? value
              .whereType<Map<String, dynamic>>()
              .where(
                (field) => field['field']?.toString().trim().isNotEmpty == true,
              )
              .toList(growable: false)
        : const <Object>[];
    return fields.isEmpty ? savedFilterSkipValue : fields;
  }
  if (type == SavedFilterCriterionType.duplication) {
    final selected = _savedFilterIds(criterion['value']).toSet();
    return {
      'modifier': 'EQUALS',
      'value': {
        for (final field in const ['phash', 'stash_id', 'title', 'url'])
          if (selected.contains(field)) field: true,
      },
    };
  }

  if (!criterion.containsKey('value2')) {
    if (criterion['excludes'] case final List<Object?> excludes
        when excludes.isEmpty) {
      return {...criterion}..remove('excludes');
    }
    return value;
  }

  return {
    for (final entry in criterion.entries)
      if (entry.key != 'value' && entry.key != 'value2') entry.key: entry.value,
    'value': {
      'value': criterion['value'],
      if (criterion['value2'] != null) 'value2': criterion['value2'],
    },
  };
}

Map<String, dynamic> _savedCriterionMetadata(Map<String, dynamic> criterion) =>
    {if (criterion['modifier'] != null) 'modifier': criterion['modifier']};

List<Map<String, String>> _savedFilterLabels(Object? value) => [
  // ponytail: filter state stores IDs only; carry display labels in criterion
  // state if official Stash needs human-readable labels from StashFlow presets.
  for (final id in _savedFilterIds(value)) {'id': id, 'label': id},
];

List<String> _savedFilterIds(Object? value) {
  if (value == null) return const [];
  if (value is! List) {
    if (value is Map) {
      return value['id'] == null ? const [] : [value['id'].toString()];
    }
    return [value.toString()];
  }
  return [
    for (final item in value)
      if (item is Map && item['id'] != null)
        item['id'].toString()
      else if (item is! Map)
        item.toString(),
  ];
}

Map<String, dynamic> savedFilterFromServerObjectFilter({
  required Map<String, dynamic> objectFilter,
  Map<String, String> serverToLocalKeys = const {},
  Map<String, SavedFilterCriterionType> criterionTypes = const {},
}) {
  final output = <String, dynamic>{};
  for (final entry in objectFilter.entries) {
    final localKey = serverToLocalKeys[entry.key] ?? entry.key;
    final decoded = _fromSavedCriterion(entry.value, criterionTypes[localKey]);
    if (identical(decoded, savedFilterSkipValue)) continue;
    output[localKey] = decoded;
  }
  return output;
}

Object? _fromSavedCriterion(Object? value, SavedFilterCriterionType? type) {
  if (type == SavedFilterCriterionType.skip) return savedFilterSkipValue;
  if (type == SavedFilterCriterionType.boolean) {
    return savedFilterReadBooleanCriterionValue(value) ?? savedFilterSkipValue;
  }

  final criterion = savedFilterAsMap(value);
  if (type == SavedFilterCriterionType.stringValue) {
    return criterion.isEmpty ? value : criterion['value']?.toString();
  }
  if (type == SavedFilterCriterionType.phash) return value;
  if (type == SavedFilterCriterionType.stashId ||
      type == SavedFilterCriterionType.customFields) {
    return value;
  }
  if (type == SavedFilterCriterionType.duplication) {
    final fields = savedFilterAsMap(criterion['value']);
    return {
      ..._savedCriterionMetadata(criterion),
      'value': [
        for (final entry in fields.entries)
          if (entry.value == true) entry.key,
      ],
    };
  }
  if (type == SavedFilterCriterionType.labeled) {
    return {
      ..._savedCriterionMetadata(criterion),
      'value': _savedFilterIds(criterion['value']),
    };
  }
  if (type == SavedFilterCriterionType.labeledWithExclusions ||
      type == SavedFilterCriterionType.hierarchical) {
    final savedValue = criterion['value'];
    if (savedValue is! Map) {
      return {...criterion, 'value': _savedFilterIds(savedValue)};
    }
    return {
      ..._savedCriterionMetadata(criterion),
      'value': _savedFilterIds(savedValue['items']),
      'excludes': _savedFilterIds(savedValue['excluded']),
      if (type == SavedFilterCriterionType.hierarchical)
        'depth': savedValue['depth'] as int? ?? 0,
    };
  }
  return value;
}

bool? savedFilterReadBooleanCriterionValue(Object? value) {
  final rawValue = value is Map ? value['value'] : value;
  if (rawValue is bool) return rawValue;
  if (rawValue is String) {
    return switch (rawValue.toLowerCase()) {
      'true' => true,
      'false' => false,
      _ => null,
    };
  }
  return null;
}
