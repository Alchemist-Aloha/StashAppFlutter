import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/studio.dart';
import '../../../images/domain/entities/image.dart' as entity;
import '../../../images/domain/entities/image_filter.dart';
import '../../../images/presentation/providers/image_list_provider.dart';
import '../../../../core/domain/entities/criterion.dart';
import 'studio_list_provider.dart';

part 'studio_details_provider.g.dart';

@riverpod
FutureOr<Studio> studioDetails(Ref ref, String id) async {
  ref.keepAlive();
  final repository = ref.read(studioRepositoryProvider);
  return repository.getStudioById(id);
}

/// Loads the first studio image page for the relationship tab.
@riverpod
FutureOr<List<entity.Image>> studioImages(Ref ref, String id) async {
  ref.keepAlive();
  return ref
      .read(imageRepositoryProvider)
      .findImages(
        page: 1,
        perPage: 48,
        sort: 'path',
        imageFilter: ImageFilter(
          studios: HierarchicalMultiCriterion(value: [id]),
        ),
      );
}
