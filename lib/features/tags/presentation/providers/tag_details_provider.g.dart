// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagDetails)
final tagDetailsProvider = TagDetailsFamily._();

final class TagDetailsProvider
    extends $FunctionalProvider<AsyncValue<Tag>, Tag, FutureOr<Tag>>
    with $FutureModifier<Tag>, $FutureProvider<Tag> {
  TagDetailsProvider._({
    required TagDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tagDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tagDetailsHash();

  @override
  String toString() {
    return r'tagDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Tag> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Tag> create(Ref ref) {
    final argument = this.argument as String;
    return tagDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TagDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tagDetailsHash() => r'765ad0ea0f52ba2d6fe23dd28ff37ac06e2bdf79';

final class TagDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Tag>, String> {
  TagDetailsFamily._()
    : super(
        retry: null,
        name: r'tagDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TagDetailsProvider call(String id) =>
      TagDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'tagDetailsProvider';
}
