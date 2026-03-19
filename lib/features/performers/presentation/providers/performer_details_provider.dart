import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/performer.dart';
import 'performer_list_provider.dart';

part 'performer_details_provider.g.dart';

@riverpod
FutureOr<Performer> performerDetails(Ref ref, String id) async {
  final repository = ref.watch(performerRepositoryProvider);
  return repository.getPerformerById(id);
}
