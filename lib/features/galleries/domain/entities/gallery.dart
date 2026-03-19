class Gallery {
  final String id;
  final String title;

  const Gallery({required this.id, required this.title});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
    );
  }
}
