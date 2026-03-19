import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/pagination.dart';
import '../../../../core/presentation/widgets/error_state_view.dart';
import '../providers/tag_list_provider.dart';

class TagsPage extends ConsumerStatefulWidget {
  const TagsPage({super.key});

  @override
  ConsumerState<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends ConsumerState<TagsPage> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(tagSearchQueryProvider.notifier).update(query);
  }

  @override
  Widget build(BuildContext context) {
    final tagsAsync = ref.watch(tagListProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search tags...',
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : const Text('Tags'),
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() => _isSearching = false);
                _searchController.clear();
                _onSearchChanged('');
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => _isSearching = true),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(tagListProvider.future),
        child: tagsAsync.when(
          data: (tags) {
            if (tags.isEmpty) {
              return const Center(child: Text('No tags found'));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (shouldLoadNextPage(scrollInfo.metrics)) {
                  ref.read(tagListProvider.notifier).fetchNextPage();
                }
                return false;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: tags.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return Card(
                    child: ListTile(
                      onTap: () => context.push('/tag/${tag.id}'),
                      title: Text(tag.name),
                      subtitle: Text(
                        'Scenes: ${tag.sceneCount}  Images: ${tag.imageCount}',
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => ErrorStateView(
            message: 'Failed to load tags.\n$err',
            onRetry: () => ref.refresh(tagListProvider),
          ),
        ),
      ),
    );
  }
}
