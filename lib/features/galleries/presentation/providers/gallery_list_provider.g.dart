// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(galleryList)
final galleryListProvider = GalleryListProvider._();

final class GalleryListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Gallery>>,
          List<Gallery>,
          FutureOr<List<Gallery>>
        >
    with $FutureModifier<List<Gallery>>, $FutureProvider<List<Gallery>> {
  GalleryListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'galleryListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$galleryListHash();

  @$internal
  @override
  $FutureProviderElement<List<Gallery>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Gallery>> create(Ref ref) {
    return galleryList(ref);
  }
}

String _$galleryListHash() => r'2b09d99da55250761824c3e3e33e3a74c8b82e38';
