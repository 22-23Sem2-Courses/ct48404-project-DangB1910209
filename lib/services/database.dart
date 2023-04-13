import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_note/models/note_model.dart';
import 'package:my_note/models/user_model.dart';
import 'package:uuid/uuid.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String noteCollection = 'notes';
  final String userCollection = 'users';

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(user.id)
          .set({"id": user.id, "name": user.name, "email": user.email});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<UserModel> getUser(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(userCollection).doc(userId).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addNote(
      String userId, String title, String content, bool important) async {
    try {
      var uuid = Uuid().v4();
      await _firestore
          .collection(userCollection)
          .doc(userId)
          .collection(noteCollection)
          .doc(uuid)
          .set({
        "id": uuid,
        "title": title,
        "content": content,
        "createdAt": Timestamp.now(),
        "important": important,
      });
    } catch (e) {}
  }

  Future<void> updateNote(String userId, String id, String title,
      String content, bool important) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(userId)
          .collection(noteCollection)
          .doc(id)
          .update({
        "title": title,
        "content": content,
        "createdAt": Timestamp.now(),
        "important": important,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNote(String userId, String id) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(userId)
          .collection(noteCollection)
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<NoteModel>> noteStream(String userId) {
    return _firestore
        .collection(userCollection)
        .doc(userId)
        .collection(noteCollection)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<NoteModel> reVal = [];
      query.docs.forEach((element) {
        reVal.add(NoteModel.fromDoc(element));
      });
      return reVal;
    });
  }
}
