import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gallery_list_provider.dart';

class GalleriesPage extends ConsumerWidget {
  const GalleriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleriesAsync = ref.watch(galleryListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Galleries')),
      body: galleriesAsync.when(
        data: (galleries) {
          if (galleries.isEmpty) {
            return const Center(child: Text('No galleries found'));
          }

          return ListView.builder(
            itemCount: galleries.length,
            itemBuilder: (context, index) {
              final gallery = galleries[index];
              return ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  gallery.title.isEmpty ? 'Untitled gallery' : gallery.title,
                ),
                subtitle: Text('ID: ${gallery.id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
