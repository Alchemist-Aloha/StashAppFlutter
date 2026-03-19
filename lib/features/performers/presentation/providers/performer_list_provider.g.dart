// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performer_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PerformerSearchQuery)
final performerSearchQueryProvider = PerformerSearchQueryProvider._();

final class PerformerSearchQueryProvider
    extends $NotifierProvider<PerformerSearchQuery, String> {
  PerformerSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performerSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performerSearchQueryHash();

  @$internal
  @override
  PerformerSearchQuery create() => PerformerSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$performerSearchQueryHash() =>
    r'ad7ecd461e2dad720f269bed09c975eb6bcba0fe';

abstract class _$PerformerSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(PerformerList)
final performerListProvider = PerformerListProvider._();

final class PerformerListProvider
    extends $AsyncNotifierProvider<PerformerList, List<Performer>> {
  PerformerListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performerListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performerListHash();

  @$internal
  @override
  PerformerList create() => PerformerList();
}

String _$performerListHash() => r'4fd486548fcf71b18c8c02c7ba06f9a929658692';

abstract class _$PerformerList extends $AsyncNotifier<List<Performer>> {
  FutureOr<List<Performer>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Performer>>, List<Performer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Performer>>, List<Performer>>,
              AsyncValue<List<Performer>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
