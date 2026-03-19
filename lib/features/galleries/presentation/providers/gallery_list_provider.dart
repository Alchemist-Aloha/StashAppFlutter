import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/gallery.dart';
import '../../domain/repositories/gallery_repository.dart';
import '../../data/repositories/graphql_gallery_repository.dart';
import '../../../../core/data/graphql/graphql_client.dart';

part 'gallery_list_provider.g.dart';

final galleryRepositoryProvider = Provider<GalleryRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphQLGalleryRepository(client);
});

@riverpod
FutureOr<List<Gallery>> galleryList(Ref ref) async {
  final repository = ref.watch(galleryRepositoryProvider);
  return repository.findGalleries(page: 1, perPage: 50);
}
