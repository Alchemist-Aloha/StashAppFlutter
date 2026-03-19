import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/pagination.dart';
import '../../../../core/presentation/widgets/error_state_view.dart';
import '../../domain/entities/performer.dart';
import '../providers/performer_list_provider.dart';
import '../widgets/performer_card.dart';

enum _PerformerSortOption { name, sceneCount, lastUpdated, random }

class PerformersPage extends ConsumerStatefulWidget {
  const PerformersPage({super.key});

  @override
  ConsumerState<PerformersPage> createState() => _PerformersPageState();
}

class _PerformersPageState extends ConsumerState<PerformersPage> {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  _PerformerSortOption _sortOption = _PerformerSortOption.name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyServerSort(_sortOption);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(performerSearchQueryProvider.notifier).update(query);
  }

  List<Performer> _sortPerformers(List<Performer> input) {
    switch (_sortOption) {
      case _PerformerSortOption.name:
      case _PerformerSortOption.sceneCount:
      case _PerformerSortOption.lastUpdated:
      case _PerformerSortOption.random:
        // Server-side ordering handles these options.
        break;
    }
    return input;
  }

  void _applyServerSort(_PerformerSortOption option) {
    switch (option) {
      case _PerformerSortOption.name:
        ref
            .read(performerListProvider.notifier)
            .setSort(sort: 'name', descending: false);
        break;
      case _PerformerSortOption.sceneCount:
        ref
            .read(performerListProvider.notifier)
            .setSort(sort: 'scene_count', descending: true);
        break;
      case _PerformerSortOption.lastUpdated:
        ref
            .read(performerListProvider.notifier)
            .setSort(sort: 'updated_at', descending: true);
        break;
      case _PerformerSortOption.random:
        ref
            .read(performerListProvider.notifier)
            .setSort(sort: 'random', descending: true);
        break;
    }
  }

  Future<void> _openRandomPerformer() async {
    final random = await ref
        .read(performerListProvider.notifier)
        .getRandomPerformer();
    if (!mounted) return;

    if (random == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No performers available for random navigation'),
        ),
      );
      return;
    }

    context.push('/performer/${random.id}');
  }

  Widget _buildSortBar() {
    const options = [
      (_PerformerSortOption.name, 'Name'),
      (_PerformerSortOption.sceneCount, 'Scene Count'),
      (_PerformerSortOption.lastUpdated, 'Last Updated'),
      (_PerformerSortOption.random, 'Random'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        children: [
          for (final option in options) ...[
            ChoiceChip(
              label: Text(option.$2),
              selected: _sortOption == option.$1,
              onSelected: (selected) {
                if (!selected) return;
                setState(() => _sortOption = option.$1);
                _applyServerSort(option.$1);
              },
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final performersAsync = ref.watch(performerListProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search performers...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: _onSearchChanged,
              )
            : const Text('Performers'),
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
      body: Column(
        children: [
          _buildSortBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(performerListProvider.future),
              child: performersAsync.when(
                data: (performers) {
                  final sortedPerformers = _sortPerformers(performers);
                  if (sortedPerformers.isEmpty) {
                    return const Center(child: Text('No performers found'));
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (shouldLoadNextPage(scrollInfo.metrics)) {
                        ref
                            .read(performerListProvider.notifier)
                            .fetchNextPage();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: sortedPerformers.length,
                      itemBuilder: (context, index) {
                        final performer = sortedPerformers[index];
                        return PerformerCard(
                          performer: performer,
                          onTap: () =>
                              context.push('/performer/${performer.id}'),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => ErrorStateView(
                  message: 'Failed to load performers.\n$err',
                  onRetry: () => ref.refresh(performerListProvider),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: performersAsync.maybeWhen(
        data: (performers) => FloatingActionButton.small(
          onPressed: _openRandomPerformer,
          tooltip: 'Random performer',
          child: const Icon(Icons.casino_outlined),
        ),
        orElse: () => null,
      ),
    );
  }
}
