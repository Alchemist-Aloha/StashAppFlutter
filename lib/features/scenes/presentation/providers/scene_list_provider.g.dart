// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SceneSort)
final sceneSortProvider = SceneSortProvider._();

final class SceneSortProvider
    extends $NotifierProvider<SceneSort, ({bool descending, String? sort})> {
  SceneSortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sceneSortProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sceneSortHash();

  @$internal
  @override
  SceneSort create() => SceneSort();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({bool descending, String? sort}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({bool descending, String? sort})>(
        value,
      ),
    );
  }
}

String _$sceneSortHash() => r'454670e56538ff99f93debc540b3367ad4a6334a';

abstract class _$SceneSort
    extends $Notifier<({bool descending, String? sort})> {
  ({bool descending, String? sort}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({bool descending, String? sort}),
              ({bool descending, String? sort})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({bool descending, String? sort}),
                ({bool descending, String? sort})
              >,
              ({bool descending, String? sort}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SceneSearchQuery)
final sceneSearchQueryProvider = SceneSearchQueryProvider._();

final class SceneSearchQueryProvider
    extends $NotifierProvider<SceneSearchQuery, String> {
  SceneSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sceneSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sceneSearchQueryHash();

  @$internal
  @override
  SceneSearchQuery create() => SceneSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$sceneSearchQueryHash() => r'e487d39e9500d8ad67c5fea24b4b0e2e5503cf12';

abstract class _$SceneSearchQuery extends $Notifier<String> {
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

@ProviderFor(SceneList)
final sceneListProvider = SceneListProvider._();

final class SceneListProvider
    extends $AsyncNotifierProvider<SceneList, List<Scene>> {
  SceneListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sceneListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sceneListHash();

  @$internal
  @override
  SceneList create() => SceneList();
}

String _$sceneListHash() => r'89dbaf897a944aab99f6e36fc5cc2c5276180069';

abstract class _$SceneList extends $AsyncNotifier<List<Scene>> {
  FutureOr<List<Scene>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Scene>>, List<Scene>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Scene>>, List<Scene>>,
              AsyncValue<List<Scene>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
