import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id;
  String? userId;
  String? title;
  String? content;
  Timestamp? createdAt;
  bool important;

  NoteModel({
    this.id,
    this.content,
    this.title,
    this.createdAt,
    this.userId,
    required this.important,
  });

  factory NoteModel.fromDoc(DocumentSnapshot noteDoc) {
    return NoteModel(
      id: noteDoc.id,
      title: noteDoc['title'],
      content: noteDoc['content'],
      important: noteDoc['important'],
      createdAt: noteDoc['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'important': important,
      'createdAt': createdAt,
    };
  }
}
