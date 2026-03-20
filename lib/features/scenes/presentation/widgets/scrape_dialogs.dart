import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/theme/app_theme.dart';
import '../providers/scene_scrape_provider.dart';
import '../../domain/entities/scraper.dart';
import '../providers/scene_details_provider.dart';

class ScrapeSourceSelector extends ConsumerWidget {
  final String sceneId;
  const ScrapeSourceSelector({required this.sceneId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapersAsync = ref.watch(sceneScrapeProvider);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusExtraLarge),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Scraper',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          scrapersAsync.when(
            data: (scrapers) => ListView.builder(
              shrinkWrap: true,
              itemCount: scrapers.length,
              itemBuilder: (context, index) {
                final scraper = scrapers[index];
                return ListTile(
                  title: Text(scraper.name),
                  onTap: () async {
                    Navigator.pop(context);
                    _executeScrape(context, ref, scraper);
                  },
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Text('Error loading scrapers: $err'),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
        ],
      ),
    );
  }

  void _executeScrape(BuildContext context, WidgetRef ref, Scraper scraper) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final results = await ref.read(sceneScrapeProvider.notifier).scrapeScene(
            scraper: scraper,
            sceneId: sceneId,
          );

      if (context.mounted) Navigator.pop(context); // Close loading dialog

      if (results.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No results found')),
          );
        }
        return;
      }

      // For MVP, just take the first result.
      final scrapedData = results.first;

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SceneScrapeEditView(
            sceneId: sceneId,
            scrapedData: scrapedData,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context); // Close loading dialog
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scrape failed: $e')),
        );
      }
    }
  }
}

class SceneScrapeEditView extends ConsumerStatefulWidget {
  final String sceneId;
  final ScrapedScene scrapedData;

  const SceneScrapeEditView({
    required this.sceneId,
    required this.scrapedData,
    super.key,
  });

  @override
  ConsumerState<SceneScrapeEditView> createState() => _SceneScrapeEditViewState();
}

class _SceneScrapeEditViewState extends ConsumerState<SceneScrapeEditView> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.scrapedData.title);
    _dateController = TextEditingController(text: widget.scrapedData.date);
    _detailsController = TextEditingController(text: widget.scrapedData.details);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusExtraLarge),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review Scraped Data',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                hintText: 'YYYY-MM-DD',
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            TextField(
              controller: _detailsController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Details',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            if (widget.scrapedData.studio != null)
              ListTile(
                title: const Text('Studio'),
                subtitle: Text(widget.scrapedData.studio!.name),
                trailing: widget.scrapedData.studio!.storedId != null
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.warning, color: Colors.orange),
              ),
            const SizedBox(height: AppTheme.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
                ),
                child: const Text('Save to Server'),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
          ],
        ),
      ),
    );
  }

  void _saveData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ref.read(sceneScrapeProvider.notifier).updateScene(
            sceneId: widget.sceneId,
            title: _titleController.text,
            date: _dateController.text,
            details: _detailsController.text,
            studioId: widget.scrapedData.studio?.storedId,
            performerIds: widget.scrapedData.performers
                .where((p) => p.storedId != null)
                .map((p) => p.storedId!)
                .toList(),
            tagIds: widget.scrapedData.tags
                .where((t) => t.storedId != null)
                .map((t) => t.storedId!)
                .toList(),
          );

      if (mounted) {
        Navigator.pop(context); // Close loading
        Navigator.pop(context); // Close edit view
        ref.invalidate(sceneDetailsProvider(widget.sceneId));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Scene updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: $e')),
        );
      }
    }
  }
}
