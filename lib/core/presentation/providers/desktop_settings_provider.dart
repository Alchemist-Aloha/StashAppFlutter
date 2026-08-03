import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopSettings {
  final double volume;
  final bool isMuted;

  DesktopSettings({this.volume = 1.0, this.isMuted = false});

  DesktopSettings copyWith({double? volume, bool? isMuted}) {
    return DesktopSettings(
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}

class DesktopSettingsNotifier extends Notifier<DesktopSettings> {
  @override
  DesktopSettings build() => DesktopSettings();

  Future<void> setVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    state = state.copyWith(volume: clampedVolume);
  }

  Future<void> toggleMute() async {
    final newMute = !state.isMuted;
    state = state.copyWith(isMuted: newMute);
  }
}

final desktopSettingsProvider =
    NotifierProvider<DesktopSettingsNotifier, DesktopSettings>(() {
      return DesktopSettingsNotifier();
    });
