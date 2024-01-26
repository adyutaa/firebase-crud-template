import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // CREATE: add a new note to the database
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get the notes from database
  Stream<QuerySnapshot> getNoteStream() {
    final noteLists = notes.orderBy('timestamp', descending: true).snapshots();
    return noteLists;
  }

  // UPDATE: update notes given the doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes givern the doc id
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
