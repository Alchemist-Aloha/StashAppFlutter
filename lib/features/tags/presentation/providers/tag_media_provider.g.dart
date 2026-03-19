// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_media_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagMedia)
final tagMediaProvider = TagMediaFamily._();

final class TagMediaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TagMediaItem>>,
          List<TagMediaItem>,
          FutureOr<List<TagMediaItem>>
        >
    with
        $FutureModifier<List<TagMediaItem>>,
        $FutureProvider<List<TagMediaItem>> {
  TagMediaProvider._({
    required TagMediaFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tagMediaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tagMediaHash();

  @override
  String toString() {
    return r'tagMediaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TagMediaItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TagMediaItem>> create(Ref ref) {
    final argument = this.argument as String;
    return tagMedia(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TagMediaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tagMediaHash() => r'04821eb241d6f4f67e6e78bf0e0ac335efeb26f7';

final class TagMediaFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TagMediaItem>>, String> {
  TagMediaFamily._()
    : super(
        retry: null,
        name: r'tagMediaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TagMediaProvider call(String tagId) =>
      TagMediaProvider._(argument: tagId, from: this);

  @override
  String toString() => r'tagMediaProvider';
}
