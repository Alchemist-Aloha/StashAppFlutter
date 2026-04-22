import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TransformableVideoSurface extends StatefulWidget {
  const TransformableVideoSurface({
    required this.controller,
    required this.aspectRatio,
    this.transformationNotifier,
    super.key,
  });

  final VideoPlayerController controller;
  final double aspectRatio;
  
  /// Optional notifier to sync transformations from external gesture detectors.
  final ValueNotifier<Matrix4>? transformationNotifier;

  @override
  State<TransformableVideoSurface> createState() => _TransformableVideoSurfaceState();
}

class _TransformableVideoSurfaceState extends State<TransformableVideoSurface> {
  late Matrix4 _transformationMatrix;

  @override
  void initState() {
    super.initState();
    _transformationMatrix = widget.transformationNotifier?.value ?? Matrix4.identity();
    widget.transformationNotifier?.addListener(_onTransformationChanged);
  }

  @override
  void didUpdateWidget(TransformableVideoSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transformationNotifier != widget.transformationNotifier) {
      oldWidget.transformationNotifier?.removeListener(_onTransformationChanged);
      widget.transformationNotifier?.addListener(_onTransformationChanged);
      if (widget.transformationNotifier != null) {
        _transformationMatrix = widget.transformationNotifier!.value;
      }
    }
  }

  @override
  void dispose() {
    widget.transformationNotifier?.removeListener(_onTransformationChanged);
    super.dispose();
  }

  void _onTransformationChanged() {
    if (mounted) {
      setState(() {
        _transformationMatrix = widget.transformationNotifier!.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Transform(
        transform: _transformationMatrix,
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
      ),
    );
  }
}
