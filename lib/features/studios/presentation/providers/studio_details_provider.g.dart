// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studio_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studioDetails)
final studioDetailsProvider = StudioDetailsFamily._();

final class StudioDetailsProvider
    extends $FunctionalProvider<AsyncValue<Studio>, Studio, FutureOr<Studio>>
    with $FutureModifier<Studio>, $FutureProvider<Studio> {
  StudioDetailsProvider._({
    required StudioDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'studioDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studioDetailsHash();

  @override
  String toString() {
    return r'studioDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Studio> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Studio> create(Ref ref) {
    final argument = this.argument as String;
    return studioDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StudioDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studioDetailsHash() => r'c847f99de18b21ee6578c3b9f9b118a3a4a72514';

final class StudioDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Studio>, String> {
  StudioDetailsFamily._()
    : super(
        retry: null,
        name: r'studioDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudioDetailsProvider call(String id) =>
      StudioDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'studioDetailsProvider';
}
