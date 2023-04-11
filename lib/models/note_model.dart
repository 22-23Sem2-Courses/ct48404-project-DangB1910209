class Note {
  String? id;
  String? notebook;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  Note({
    required this.id,
    required this.content,
    required this.title,
    required this.notebook,
    required this.createdAt,
    required this.updatedAt,
  });
}
