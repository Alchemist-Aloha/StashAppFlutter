// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sceneDetails)
final sceneDetailsProvider = SceneDetailsFamily._();

final class SceneDetailsProvider
    extends $FunctionalProvider<AsyncValue<Scene>, Scene, FutureOr<Scene>>
    with $FutureModifier<Scene>, $FutureProvider<Scene> {
  SceneDetailsProvider._({
    required SceneDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'sceneDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sceneDetailsHash();

  @override
  String toString() {
    return r'sceneDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Scene> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Scene> create(Ref ref) {
    final argument = this.argument as String;
    return sceneDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SceneDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sceneDetailsHash() => r'e38832198f88d4dc8bc8411988a19a3121efbec4';

final class SceneDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Scene>, String> {
  SceneDetailsFamily._()
    : super(
        retry: null,
        name: r'sceneDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SceneDetailsProvider call(String id) =>
      SceneDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'sceneDetailsProvider';
}
