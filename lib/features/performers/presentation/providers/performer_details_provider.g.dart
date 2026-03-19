// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performer_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(performerDetails)
final performerDetailsProvider = PerformerDetailsFamily._();

final class PerformerDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Performer>,
          Performer,
          FutureOr<Performer>
        >
    with $FutureModifier<Performer>, $FutureProvider<Performer> {
  PerformerDetailsProvider._({
    required PerformerDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'performerDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$performerDetailsHash();

  @override
  String toString() {
    return r'performerDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Performer> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Performer> create(Ref ref) {
    final argument = this.argument as String;
    return performerDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PerformerDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$performerDetailsHash() => r'9f69dc4a5b3bf4a05c88410cdaf50d463a521567';

final class PerformerDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Performer>, String> {
  PerformerDetailsFamily._()
    : super(
        retry: null,
        name: r'performerDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PerformerDetailsProvider call(String id) =>
      PerformerDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'performerDetailsProvider';
}
