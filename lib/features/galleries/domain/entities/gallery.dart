class Gallery {
  final String id;
  final String title;
  final String? date;
  final int? rating100;
  final int? imageCount;
  final String? details;
  final String? path;
  final String? coverPath;
  final int? coverWidth;
  final int? coverHeight;
  final String? studioId;
  final String? studioName;
  final List<String> performerIds;
  final List<String> performerNames;
  final List<String?> performerImagePaths;

  static final _separatorRegExp = RegExp(r'[_\.]+');

  const Gallery({
    required this.id,
    required this.title,
    this.date,
    this.rating100,
    this.imageCount,
    this.details,
    this.path,
    this.coverPath,
    this.coverWidth,
    this.coverHeight,
    this.studioId,
    this.studioName,
    this.performerIds = const [],
    this.performerNames = const [],
    this.performerImagePaths = const [],
  });

  /// The display title of the gallery.
  ///
  /// Returns [title] if it is not empty, otherwise returns the filestem
  /// from [path], and finally 'Untitled gallery' if neither is available.
  String get displayName {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isNotEmpty) return trimmedTitle;

    if (path != null && path!.isNotEmpty) {
      final normalized = path!.replaceAll('\\', '/');
      final segments = normalized.split('/');
      final filename = segments.lastWhere(
        (s) => s.isNotEmpty,
        orElse: () => '',
      );
      if (filename.isNotEmpty) {
        final dotIndex = filename.lastIndexOf('.');
        final stem = dotIndex > 0 ? filename.substring(0, dotIndex) : filename;
        final cleaned = stem.replaceAll(_separatorRegExp, ' ').trim();
        if (cleaned.isNotEmpty) return cleaned;
      }
    }

    return 'Untitled gallery';
  }

  factory Gallery.fromJson(Map<String, dynamic> json) {
    String? path;
    final files = json['files'] as List<dynamic>?;
    if (files != null && files.isNotEmpty) {
      path = files.first['path']?.toString();
    }

    final paths = json['paths'] as Map<String, dynamic>?;
    final coverPath = paths?['cover']?.toString();

    int? coverWidth;
    int? coverHeight;
    final cover = json['cover'] as Map<String, dynamic>?;
    if (cover != null) {
      final visualFiles = cover['visual_files'] as List<dynamic>?;
      if (visualFiles != null && visualFiles.isNotEmpty) {
        coverWidth = visualFiles.first['width'] as int?;
        coverHeight = visualFiles.first['height'] as int?;
      }
    }

    final studio = json['studio'] as Map<String, dynamic>?;
    final performers = (json['performers'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();

    return Gallery(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      date: json['date']?.toString(),
      rating100: json['rating100'] as int?,
      imageCount: json['image_count'] as int?,
      details: json['details']?.toString(),
      path: path,
      coverPath: coverPath,
      coverWidth: coverWidth,
      coverHeight: coverHeight,
      studioId: studio?['id']?.toString(),
      studioName: studio?['name']?.toString(),
      performerIds: performers
          .map((performer) => performer['id']?.toString() ?? '')
          .toList(),
      performerNames: performers
          .map((performer) => performer['name']?.toString() ?? '')
          .toList(),
      performerImagePaths: performers
          .map((performer) => performer['image_path']?.toString())
          .toList(),
    );
  }
}
