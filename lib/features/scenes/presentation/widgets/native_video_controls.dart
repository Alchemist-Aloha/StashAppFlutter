import 'dart:async';
import 'dart:math' as math;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/utils/pip_mode.dart';
import '../providers/video_player_provider.dart';

class NativeVideoControls extends ConsumerStatefulWidget {
  const NativeVideoControls({
    required this.controller,
    required this.useDoubleTapSeek,
    required this.enableNativePip,
    this.onFullScreenToggle,
    super.key,
  });

  final VideoPlayerController controller;
  final bool useDoubleTapSeek;
  final bool enableNativePip;
  final VoidCallback? onFullScreenToggle;

  @override
  ConsumerState<NativeVideoControls> createState() => _NativeVideoControlsState();
}

class _NativeVideoControlsState extends ConsumerState<NativeVideoControls>
    with WidgetsBindingObserver {
  static const _playbackSpeeds = <double>[0.75, 1.0, 1.25, 1.5, 2.0];
  static const _controlsAutoHideDelay = Duration(seconds: 3);
  static const _gestureSeekSeconds = 10;
  static const _controlsTouchSafeHeight = 122.0;
  static const _dragSeekSensitivity = 0.30;
  static const _dragSeekCurveExponent = 1.6;

  bool _isScrubbing = false;
  double _scrubMs = 0;
  bool _controlsVisible = true;
  bool _wasPlaying = false;
  Timer? _hideControlsTimer;
  Duration? _dragSeekStartPosition;
  double _dragSeekAccumulatedDx = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.controller.addListener(_onVideoTick);
    _wasPlaying = widget.controller.value.isPlaying;
    if (_wasPlaying) {
      _scheduleAutoHide();
    }
  }

  @override
  void didUpdateWidget(covariant NativeVideoControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onVideoTick);
      widget.controller.addListener(_onVideoTick);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelAutoHide();
    widget.controller.removeListener(_onVideoTick);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.enableNativePip || !Platform.isAndroid) return;
    if (state != AppLifecycleState.paused) return;

    final controller = widget.controller;
    if (!controller.value.isPlaying) return;
    
    final isFullScreen = ref.read(playerStateProvider).isFullScreen;
    if (!isFullScreen) return;
    
    unawaited(PipMode.enterIfAvailable());
  }

  void _onVideoTick() {
    if (!mounted) return;

    final isPlaying = widget.controller.value.isPlaying;
    if (isPlaying != _wasPlaying) {
      _wasPlaying = isPlaying;
      if (isPlaying) {
        _scheduleAutoHide();
      } else {
        _cancelAutoHide();
        setState(() => _controlsVisible = true);
      }
    }

    if (_isScrubbing) return;
    setState(() {});
  }

  void _cancelAutoHide() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = null;
  }

  void _scheduleAutoHide() {
    _cancelAutoHide();
    final isPlaying = widget.controller.value.isPlaying;
    if (!isPlaying || _isScrubbing) return;

    _hideControlsTimer = Timer(_controlsAutoHideDelay, () {
      if (!mounted) return;
      final stillPlaying = widget.controller.value.isPlaying;
      if (!stillPlaying || _isScrubbing || !_controlsVisible) return;
      setState(() => _controlsVisible = false);
    });
  }

  void _toggleControls() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
    if (_controlsVisible) {
      _scheduleAutoHide();
    } else {
      _cancelAutoHide();
    }
  }

  void _showControlsTemporarily() {
    if (!_controlsVisible) {
      setState(() => _controlsVisible = true);
    }
    _scheduleAutoHide();
  }

  void _seekRelativeSeconds(int seconds) {
    if (!widget.controller.value.isInitialized) return;
    final current = widget.controller.value.position;
    final duration = widget.controller.value.duration;
    var target = current + Duration(seconds: seconds);
    if (target < Duration.zero) target = Duration.zero;
    if (target > duration) target = duration;
    widget.controller.seekTo(target);
  }

  void _beginDragSeek() {
    if (!widget.controller.value.isInitialized) return;
    _dragSeekStartPosition = widget.controller.value.position;
    _dragSeekAccumulatedDx = 0;
  }

  void _updateDragSeek(DragUpdateDetails details, double dragAreaWidth) {
    final startPosition = _dragSeekStartPosition;
    if (!widget.controller.value.isInitialized || startPosition == null) return;
    if (dragAreaWidth <= 0) return;

    final duration = widget.controller.value.duration;
    if (duration <= Duration.zero) return;

    _dragSeekAccumulatedDx += details.primaryDelta ?? 0;
    final linearDragRatio = _dragSeekAccumulatedDx / dragAreaWidth;
    final curvedMagnitude = math
        .pow(linearDragRatio.abs(), _dragSeekCurveExponent)
        .toDouble();
    final curvedDragRatio = linearDragRatio.isNegative
        ? -curvedMagnitude
        : curvedMagnitude;

    final deltaMs =
        curvedDragRatio * duration.inMilliseconds * _dragSeekSensitivity;
    final unclampedTargetMs = startPosition.inMilliseconds + deltaMs;
    final targetMs = unclampedTargetMs.clamp(
      0,
      duration.inMilliseconds.toDouble(),
    );

    widget.controller.seekTo(Duration(milliseconds: targetMs.round()));
  }

  void _endDragSeek() {
    _dragSeekStartPosition = null;
    _dragSeekAccumulatedDx = 0;
  }

  String _format(Duration d) {
    final totalSeconds = d.inSeconds;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatSpeed(double speed) {
    final whole = speed.roundToDouble() == speed;
    return whole
        ? '${speed.toStringAsFixed(0)}x'
        : '${speed.toStringAsFixed(2)}x';
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.controller.value;
    final duration = value.duration;
    final durationMs = math.max(1, duration.inMilliseconds);
    final playbackSpeed = value.playbackSpeed;
    final isFullScreen = ref.watch(playerStateProvider).isFullScreen;

    final currentMs = _isScrubbing
        ? _scrubMs
        : value.position.inMilliseconds.toDouble();
    final sliderValue = currentMs.clamp(0, durationMs.toDouble()).toDouble();

    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                child: widget.useDoubleTapSeek
                    ? Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: _toggleControls,
                              onDoubleTap: () {
                                _seekRelativeSeconds(-_gestureSeekSeconds);
                              },
                              child: const ColoredBox(color: Colors.transparent),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: _toggleControls,
                              onDoubleTap: () {
                                _seekRelativeSeconds(_gestureSeekSeconds);
                              },
                              child: const ColoredBox(color: Colors.transparent),
                            ),
                          ),
                        ],
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _toggleControls,
                            onHorizontalDragStart: (_) {
                              _beginDragSeek();
                            },
                            onHorizontalDragUpdate: (details) {
                              _updateDragSeek(details, constraints.maxWidth);
                            },
                            onHorizontalDragEnd: (_) {
                              _endDragSeek();
                            },
                            onHorizontalDragCancel: _endDragSeek,
                            child: const ColoredBox(color: Colors.transparent),
                          );
                        },
                      ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: _controlsVisible ? _controlsTouchSafeHeight : 0,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            opacity: _controlsVisible ? 1 : 0,
            duration: const Duration(milliseconds: 180),
            child: IgnorePointer(
              ignoring: !_controlsVisible,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00000000),
                      Color(0x88000000),
                      Color(0xCC000000),
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 7,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 14,
                        ),
                        activeTrackColor: const Color(0xFFECECEC),
                        inactiveTrackColor: const Color(0x55FFFFFF),
                        thumbColor: Colors.white,
                      ),
                      child: Slider(
                        min: 0,
                        max: durationMs.toDouble(),
                        value: sliderValue,
                        onChangeStart: (v) {
                          _cancelAutoHide();
                          setState(() {
                            _isScrubbing = true;
                            _scrubMs = v;
                            _controlsVisible = true;
                          });
                        },
                        onChanged: (v) {
                          setState(() => _scrubMs = v);
                        },
                        onChangeEnd: (v) {
                          final target = Duration(milliseconds: v.round());
                          widget.controller.seekTo(target);
                          setState(() {
                            _isScrubbing = false;
                            _scrubMs = 0;
                          });
                          _scheduleAutoHide();
                        },
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Material(
                          color: const Color(0x30FFFFFF),
                          shape: const CircleBorder(),
                          child: IconButton(
                            iconSize: 24,
                            icon: Icon(
                              value.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (value.isPlaying) {
                                widget.controller.pause();
                              } else {
                                widget.controller.play();
                              }
                              _showControlsTemporarily();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_format(Duration(milliseconds: sliderValue.round()))} / ${_format(duration)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        PopupMenuButton<double>(
                          tooltip: 'Playback speed',
                          initialValue: playbackSpeed,
                          color: const Color(0xEE1C1C1C),
                          onSelected: (speed) async {
                            await widget.controller.setPlaybackSpeed(speed);
                            _showControlsTemporarily();
                          },
                          itemBuilder: (context) {
                            return _playbackSpeeds
                                .map(
                                  (speed) => PopupMenuItem<double>(
                                    value: speed,
                                    child: Row(
                                      children: [
                                        Icon(
                                          speed == playbackSpeed
                                              ? Icons.check_circle
                                              : Icons.circle_outlined,
                                          size: 16,
                                          color: speed == playbackSpeed
                                              ? Colors.white
                                              : Colors.white70,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _formatSpeed(speed),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x30FFFFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _formatSpeed(playbackSpeed),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (widget.enableNativePip && Platform.isAndroid)
                          IconButton(
                            tooltip: 'Picture-in-Picture',
                            icon: const Icon(
                              Icons.picture_in_picture_alt_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (!isFullScreen) {
                                widget.onFullScreenToggle?.call();
                                // Small delay to allow transition
                                await Future.delayed(const Duration(milliseconds: 150));
                              }
                              await PipMode.enterIfAvailable();
                              _showControlsTemporarily();
                            },
                          ),
                        IconButton(
                          icon: Icon(
                            isFullScreen
                                ? Icons.fullscreen_exit_rounded
                                : Icons.fullscreen_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            widget.onFullScreenToggle?.call();
                            _showControlsTemporarily();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
