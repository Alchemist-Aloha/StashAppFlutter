// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studio_media_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studioMedia)
final studioMediaProvider = StudioMediaFamily._();

final class StudioMediaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StudioMediaItem>>,
          List<StudioMediaItem>,
          FutureOr<List<StudioMediaItem>>
        >
    with
        $FutureModifier<List<StudioMediaItem>>,
        $FutureProvider<List<StudioMediaItem>> {
  StudioMediaProvider._({
    required StudioMediaFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'studioMediaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studioMediaHash();

  @override
  String toString() {
    return r'studioMediaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<StudioMediaItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StudioMediaItem>> create(Ref ref) {
    final argument = this.argument as String;
    return studioMedia(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StudioMediaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studioMediaHash() => r'580849a9e2876c376b1feb5d21d7b4540d2d8147';

final class StudioMediaFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<StudioMediaItem>>, String> {
  StudioMediaFamily._()
    : super(
        retry: null,
        name: r'studioMediaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudioMediaProvider call(String studioId) =>
      StudioMediaProvider._(argument: studioId, from: this);

  @override
  String toString() => r'studioMediaProvider';
}
