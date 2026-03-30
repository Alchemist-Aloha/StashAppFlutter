import '../entities/image.dart';

abstract class ImageRepository {
  Future<List<Image>> findImages({
    int? page,
    int? perPage,
    String? filter,
    String? sort,
    bool? descending,
    String? galleryId,
  });
  Future<Image> getImageById(String id, {bool refresh = false});
}
