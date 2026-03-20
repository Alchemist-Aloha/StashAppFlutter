// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_scrape_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SceneScrape)
final sceneScrapeProvider = SceneScrapeProvider._();

final class SceneScrapeProvider
    extends $AsyncNotifierProvider<SceneScrape, List<Scraper>> {
  SceneScrapeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sceneScrapeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sceneScrapeHash();

  @$internal
  @override
  SceneScrape create() => SceneScrape();
}

String _$sceneScrapeHash() => r'ec2600d53ac3a2f08d35889ad1afa6ec84a7097c';

abstract class _$SceneScrape extends $AsyncNotifier<List<Scraper>> {
  FutureOr<List<Scraper>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Scraper>>, List<Scraper>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Scraper>>, List<Scraper>>,
              AsyncValue<List<Scraper>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
