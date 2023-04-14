import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class NoteModel extends ChangeNotifier {
  List<DocumentSnapshot> _notes = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? id;
  String? title;
  String? content;
  Timestamp? createdAt;
  bool? important;
  bool? isDelete;

  NoteModel({
    this.id,
    this.content,
    this.title,
    this.createdAt,
    this.important,
    this.isDelete,
  });

  factory NoteModel.fromDoc(DocumentSnapshot noteDoc) {
    return NoteModel(
      id: noteDoc.id,
      title: noteDoc['title'],
      content: noteDoc['content'],
      important: noteDoc['important'],
      createdAt: noteDoc['createdAt'],
      isDelete: noteDoc['isDelete'],
    );
  }

  Future<void> fetchNotes() async {
    final snapshot = FirebaseFirestore.instance
        .collection('notes')
        .snapshots()
        .listen((snapshot) {
      _notes = snapshot.docs;
      notifyListeners();
    });
  }

  Future<void> addNote(String title, String content, bool important) async {
    try {
      var uuid = const Uuid().v4();
      await _firestore.collection('notes').doc(uuid).set({
        "id": uuid,
        "title": title,
        "content": content,
        "createdAt": Timestamp.now(),
        "important": important,
        "isDelete": false,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateNote(String id, String title, String content) async {
    try {
      await _firestore.collection("notes").doc(id).update({
        "title": title,
        "content": content,
        "createdAt": Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> changImportant(String id, bool important) async {
    try {
      await _firestore.collection("notes").doc(id).update({
        "important": important,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> moveToTrash(String id) async {
    try {
      await _firestore.collection("notes").doc(id).update({
        "isDelete": true,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _firestore.collection("notes").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  List<DocumentSnapshot> get notes => _notes;
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
