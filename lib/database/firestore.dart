import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // CREATE: add a new note to the database
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // READ: get the notes from database
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // UPDATE: update notes given the doc id

  // DELETE: delete notes givern the doc id
}
