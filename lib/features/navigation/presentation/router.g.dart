// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Central application router defined using GoRouter and Riverpod.
///
/// This provider creates a [GoRouter] instance that handles:
/// 1. Tab-based navigation via [StatefulShellRoute].
/// 2. Deep linking to scenes, performers, studios, and tags.
/// 3. Redirection to the settings page if the Stash server is not configured.
/// 4. Immersive fullscreen transitions for the video player.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// Central application router defined using GoRouter and Riverpod.
///
/// This provider creates a [GoRouter] instance that handles:
/// 1. Tab-based navigation via [StatefulShellRoute].
/// 2. Deep linking to scenes, performers, studios, and tags.
/// 3. Redirection to the settings page if the Stash server is not configured.
/// 4. Immersive fullscreen transitions for the video player.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Central application router defined using GoRouter and Riverpod.
  ///
  /// This provider creates a [GoRouter] instance that handles:
  /// 1. Tab-based navigation via [StatefulShellRoute].
  /// 2. Deep linking to scenes, performers, studios, and tags.
  /// 3. Redirection to the settings page if the Stash server is not configured.
  /// 4. Immersive fullscreen transitions for the video player.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'340b24e0f8f79dbc6e1507ca7ccd9e240db9fb97';
