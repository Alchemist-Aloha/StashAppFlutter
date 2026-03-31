import '../domain/entities/scene.dart';
import '../graphql/scenes.graphql.dart';
import '../../../../core/utils/data_mapper.dart';

extension SceneMapper on Fragment$Scene {
  Scene toDomain() {
    return Scene(
      id: id,
      title: title ?? '',
      details: null, // Basic fragment doesn't usually have full details
      path: files.isNotEmpty ? files.first.path : null,
      date: DateTime.tryParse(date ?? '') ?? DateTime.now(),
      rating100: rating100,
      oCounter: o_counter ?? 0,
      organized: organized,
      interactive: interactive,
      resumeTime: resume_time,
      playCount: play_count ?? 0,
      files: files.map((f) => f.toDomain()).toList(),
      paths: ScenePaths(
        screenshot: paths.screenshot,
        preview: paths.preview,
        stream: paths.stream,
        webp: paths.webp,
        vtt: paths.vtt,
        chapters: paths.chapters,
        sprite: paths.sprite,
        funscript: paths.funscript,
      ),
      studioId: studio?.id,
      studioName: studio?.name,
      performers: performers.map((p) => p.toDomain()).toList(),
      tags: tags.map((t) => t.toDomain()).toList(),
    );
  }
}

extension SceneFileMapper on Fragment$Scene$files {
  SceneFile toDomain() {
    return SceneFile(
      format: null,
      width: null,
      height: null,
      videoCodec: null,
      audioCodec: null,
      bitRate: null,
      duration: duration,
      frameRate: null,
    );
  }
}

extension ScenePerformerMapper on Fragment$Scene$performers {
  ScenePerformer toDomain() {
    return ScenePerformer(
      id: id,
      name: name,
      imagePath: image_path,
      gender: gender?.name,
      favorite: favorite,
    );
  }
}

extension SceneTagMapper on Fragment$Scene$tags {
  SceneTag toDomain() {
    return SceneTag(
      id: id,
      name: name,
    );
  }
}

extension SceneDetailsMapper on Query$FindScene$findScene {
  Scene toDomain() {
    return Scene(
      id: id,
      title: title ?? '',
      details: details,
      path: files.isNotEmpty ? files.first.path : null,
      date: DateTime.tryParse(date ?? '') ?? DateTime.now(),
      rating100: rating100,
      oCounter: o_counter ?? 0,
      organized: organized,
      interactive: interactive,
      resumeTime: resume_time,
      playCount: play_count ?? 0,
      files: files.map((f) => f.toDomain()).toList(),
      paths: ScenePaths(
        screenshot: paths.screenshot,
        preview: paths.preview,
        stream: paths.stream,
        webp: paths.webp,
        vtt: paths.vtt,
        chapters: paths.chapters,
        sprite: paths.sprite,
        funscript: paths.funscript,
      ),
      studioId: studio?.id,
      studioName: studio?.name,
      performers: performers.map((p) => p.toDomain()).toList(),
      tags: tags.map((t) => t.toDomain()).toList(),
    );
  }
}

extension SceneDetailsFileMapper on Query$FindScene$findScene$files {
  SceneFile toDomain() {
    return SceneFile(
      format: null, // Could map if available in FindScene query
      width: width,
      height: height,
      videoCodec: video_codec,
      audioCodec: audio_codec,
      bitRate: bit_rate,
      duration: duration,
      frameRate: frame_rate,
    );
  }
}

extension SceneDetailsPerformerMapper on Query$FindScene$findScene$performers {
  ScenePerformer toDomain() {
    return ScenePerformer(
      id: id,
      name: name,
      imagePath: image_path,
      gender: gender?.name,
      favorite: favorite,
    );
  }
}

extension SceneDetailsTagMapper on Query$FindScene$findScene$tags {
  SceneTag toDomain() {
    return SceneTag(
      id: id,
      name: name,
    );
  }
}
