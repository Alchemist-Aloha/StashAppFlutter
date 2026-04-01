import 'dart:async';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/image.dart' as entity;
import '../providers/image_list_provider.dart';
import '../../../../core/data/graphql/media_headers_provider.dart';
import '../../../../core/utils/responsive.dart';

enum _SlideshowDirection { forward, backward }

class ImageFullscreenPage extends ConsumerStatefulWidget {
  final String imageId;

  const ImageFullscreenPage({required this.imageId, super.key});

  @override
  ConsumerState<ImageFullscreenPage> createState() =>
      _ImageFullscreenPageState();
}

class _ImageFullscreenPageState extends ConsumerState<ImageFullscreenPage> {
  late ExtendedPageController _pageController;
  Timer? _slideshowTimer;
  int _currentIndex = 0;
  bool _initialPageSet = false;
  bool _showOverlays = true;
  bool _isSlideshowPlaying = false;
  Duration _slideshowInterval = const Duration(seconds: 3);
  Duration _slideshowTransition = const Duration(milliseconds: 380);
  bool _slideshowLoop = true;
  _SlideshowDirection _slideshowDirection = _SlideshowDirection.forward;
  Offset? _pointerDownPosition;
  DateTime? _pointerDownTime;

  @override
  void initState() {
    super.initState();
    _pageController = ExtendedPageController();
  }

  @override
  void dispose() {
    _stopSlideshow();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleOverlays() {
    setState(() => _showOverlays = !_showOverlays);
  }

  void _onPointerDown(PointerDownEvent event) {
    _pointerDownPosition = event.position;
    _pointerDownTime = DateTime.now();
  }

  void _onPointerUp(PointerUpEvent event) {
    final downPos = _pointerDownPosition;
    final downTime = _pointerDownTime;
    _pointerDownPosition = null;
    _pointerDownTime = null;

    if (downPos == null || downTime == null) return;

    final movedDistance = (event.position - downPos).distance;
    final elapsed = DateTime.now().difference(downTime);

    // Use pointer events instead of a GestureDetector so swipe gestures
    // are not forced to compete with an extra tap recognizer.
    if (elapsed <= const Duration(milliseconds: 220) && movedDistance < 10) {
      _toggleOverlays();
    }
  }

  void _handlePageChanged(
    int index,
    List<entity.Image> items,
    Map<String, String> headers,
  ) {
    setState(() => _currentIndex = index);
    _prefetchAdjacent(items, index, headers);

    if (index >= items.length - 5) {
      ref.read(imageListProvider.notifier).fetchNextPage();
    }
  }

  void _stopSlideshow() {
    _slideshowTimer?.cancel();
    _slideshowTimer = null;
    if (_isSlideshowPlaying && mounted) {
      setState(() => _isSlideshowPlaying = false);
    }
  }

  void _advanceSlideshow(int itemCount) {
    if (!_isSlideshowPlaying || !_pageController.hasClients || !mounted) return;
    if (itemCount <= 1) {
      _stopSlideshow();
      return;
    }

    final delta = _slideshowDirection == _SlideshowDirection.forward ? 1 : -1;
    var targetIndex = _currentIndex + delta;

    if (targetIndex < 0 || targetIndex >= itemCount) {
      if (!_slideshowLoop) {
        _stopSlideshow();
        return;
      }
      targetIndex = _slideshowDirection == _SlideshowDirection.forward
          ? 0
          : itemCount - 1;
    }

    _pageController.animateToPage(
      targetIndex,
      duration: _slideshowTransition,
      curve: Curves.easeInOutCubic,
    );
  }

  void _startSlideshow(int itemCount) {
    if (itemCount <= 1) return;

    _slideshowTimer?.cancel();
    setState(() => _isSlideshowPlaying = true);
    _slideshowTimer = Timer.periodic(_slideshowInterval, (_) {
      _advanceSlideshow(itemCount);
    });
  }

  Future<void> _toggleSlideshow(int itemCount) async {
    if (_isSlideshowPlaying) {
      _stopSlideshow();
      return;
    }

    if (itemCount <= 1) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Need at least 2 images for slideshow.')),
      );
      return;
    }

    double intervalSeconds = _slideshowInterval.inMilliseconds / 1000;
    double transitionMs = _slideshowTransition.inMilliseconds.toDouble();
    bool loop = _slideshowLoop;
    _SlideshowDirection direction = _slideshowDirection;

    final shouldStart = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Start Slideshow'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Interval: ${intervalSeconds.toStringAsFixed(1)}s'),
                    Slider(
                      value: intervalSeconds,
                      min: 1,
                      max: 15,
                      divisions: 28,
                      label: '${intervalSeconds.toStringAsFixed(1)}s',
                      onChanged: (v) {
                        setDialogState(() => intervalSeconds = v);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text('Transition: ${transitionMs.round()}ms'),
                    Slider(
                      value: transitionMs,
                      min: 120,
                      max: 1400,
                      divisions: 32,
                      label: '${transitionMs.round()}ms',
                      onChanged: (v) {
                        setDialogState(() => transitionMs = v);
                      },
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<_SlideshowDirection>(
                      segments: const [
                        ButtonSegment<_SlideshowDirection>(
                          value: _SlideshowDirection.forward,
                          label: Text('Forward'),
                          icon: Icon(Icons.arrow_downward_rounded),
                        ),
                        ButtonSegment<_SlideshowDirection>(
                          value: _SlideshowDirection.backward,
                          label: Text('Backward'),
                          icon: Icon(Icons.arrow_upward_rounded),
                        ),
                      ],
                      selected: <_SlideshowDirection>{direction},
                      onSelectionChanged: (selection) {
                        setDialogState(() => direction = selection.first);
                      },
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Loop slideshow'),
                      value: loop,
                      onChanged: (v) {
                        setDialogState(() => loop = v);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start'),
                ),
              ],
            );
          },
        );
      },
    );

    if (shouldStart != true || !mounted) return;

    setState(() {
      _slideshowInterval = Duration(
        milliseconds: (intervalSeconds * 1000).round(),
      );
      _slideshowTransition = Duration(milliseconds: transitionMs.round());
      _slideshowLoop = loop;
      _slideshowDirection = direction;
    });
    _startSlideshow(itemCount);
  }

  void _prefetchAdjacent(
    List<entity.Image> items,
    int index,
    Map<String, String> headers,
  ) {
    // Prefetch next 2 and previous 1
    for (var i = 1; i <= 2; i++) {
      if (index + i < items.length) {
        final url = items[index + i].paths.image ?? items[index + i].paths.preview;
        if (url != null) {
          precacheImage(
            ExtendedNetworkImageProvider(url, headers: headers, cache: true),
            context,
          );
        }
      }
    }
    if (index - 1 >= 0) {
      final url = items[index - 1].paths.image ?? items[index - 1].paths.preview;
      if (url != null) {
        precacheImage(
          ExtendedNetworkImageProvider(url, headers: headers, cache: true),
          context,
        );
      }
    }
  }

  String _getDisplayTitle(entity.Image? image) {
    if (image == null) return '';
    if (image.title != null && image.title!.trim().isNotEmpty) {
      return image.title!.trim();
    }
    if (image.files.isNotEmpty) {
      final path = image.files.first.path;
      if (path.isNotEmpty) {
        final segments = path.replaceAll('\\', '/').split('/');
        return segments.lastWhere((s) => s.isNotEmpty, orElse: () => path);
      }
    }
    return 'Untitled';
  }

  Widget _buildOverlayHeader(
    BuildContext context,
    String displayTitle,
    int itemCount,
    double maxOverlayWidth,
    double horizontalPadding,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 8,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxOverlayWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.78),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: 0.35,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        IconButton.filledTonal(
                          icon: const Icon(Icons.arrow_back_rounded),
                          onPressed: () => context.pop(),
                          tooltip: 'Back',
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                displayTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${_currentIndex + 1} / $itemCount',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          icon: Icon(
                            _isSlideshowPlaying
                                ? Icons.stop_rounded
                                : Icons.slideshow_rounded,
                          ),
                          onPressed: () => _toggleSlideshow(itemCount),
                          tooltip: _isSlideshowPlaying
                              ? 'Stop slideshow'
                              : 'Start slideshow',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayFooter(
    BuildContext context,
    int itemCount,
    double maxOverlayWidth,
    double horizontalPadding,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final progress = itemCount > 1 ? _currentIndex / (itemCount - 1) : 0.0;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 8,
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxOverlayWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.72,
                      ),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _isSlideshowPlaying ? 'Playing' : 'Tap to toggle UI',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagesAsync = ref.watch(imageListProvider);
    final headers = ref.watch(mediaHeadersProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: imagesAsync.when(
        data: (items) {
          if (!_initialPageSet) {
            _currentIndex = items.indexWhere((i) => i.id == widget.imageId);
            if (_currentIndex == -1) _currentIndex = 0;
            _pageController.dispose();
            _pageController = ExtendedPageController(
              initialPage: _currentIndex,
            );
            _initialPageSet = true;

            // Prefetch initial adjacent images
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _prefetchAdjacent(items, _currentIndex, headers);
            });
          }

          final currentImage = items.isNotEmpty ? items[_currentIndex] : null;
          final displayTitle = _getDisplayTitle(currentImage);

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWideLayout =
                  constraints.maxWidth >= Responsive.tabletBreakpoint;
              final scrollDirection =
                  isWideLayout ? Axis.horizontal : Axis.vertical;
              final maxOverlayWidth = isWideLayout ? 720.0 : constraints.maxWidth;
              final horizontalPadding = isWideLayout ? 24.0 : 8.0;

              return Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: _onPointerDown,
                onPointerUp: _onPointerUp,
                child: Stack(
                  children: [
                    ExtendedImageGesturePageView.builder(
                      controller: _pageController,
                      scrollDirection: scrollDirection,
                      itemCount: items.length,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        _handlePageChanged(index, items, headers);
                      },
                      itemBuilder: (context, index) {
                        final image = items[index];
                        final imageUrl = image.paths.image ?? image.paths.preview;

                        if (imageUrl == null || imageUrl.isEmpty) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white54,
                              size: 64,
                            ),
                          );
                        }

                        return RepaintBoundary(
                          child: ExtendedImage.network(
                            imageUrl,
                            headers: headers,
                            fit: BoxFit.contain,
                            mode: ExtendedImageMode.gesture,
                            cache: true,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.9,
                                animationMinScale: 0.7,
                                maxScale: 5.0,
                                animationMaxScale: 6.0,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: 1.0,
                                inPageView: true,
                                initialAlignment: InitialAlignment.center,
                              );
                            },
                            onDoubleTap: (ExtendedImageGestureState state) {
                              final pointerDownPosition =
                                  state.pointerDownPosition;
                              final begin = state.gestureDetails!.totalScale;
                              final end = begin == 1.0 ? 3.0 : 1.0;

                              state.handleDoubleTap(
                                scale: end,
                                doubleTapPosition: pointerDownPosition,
                              );
                            },
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                case LoadState.completed:
                                  return state.completedWidget;
                                case LoadState.failed:
                                  return GestureDetector(
                                    onTap: () => state.reLoadImage(),
                                    child: const Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.broken_image,
                                            color: Colors.white54,
                                            size: 64,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Failed to load. Tap to retry.',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                              }
                            },
                          ),
                        );
                      },
                    ),
                    if (_showOverlays) ...[
                      _buildOverlayHeader(
                        context,
                        displayTitle,
                        items.length,
                        maxOverlayWidth,
                        horizontalPadding,
                      ),
                      _buildOverlayFooter(
                        context,
                        items.length,
                        maxOverlayWidth,
                        horizontalPadding,
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
