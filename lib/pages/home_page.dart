import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_template/database/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final TextEditingController textController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  // open dialog box to add a new note
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      // add a new note button function
                      //add a new note
                      if (docID == null) {
                        firestoreService.addNote(textController.text);
                      } else {
                        // update an existing note
                        firestoreService.updateNote(docID, textController.text);
                      }
                      //clear the text
                      textController.clear();
                      // dismiss the dialog box
                      Navigator.pop(context);
                    },
                    child: Text("add"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNoteStream(),
        builder: (context, snapshot) {
          // if we have the data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as list
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  // get each individual docs
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  // get note from each docs
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  //display list as title
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // update button
                        IconButton(
                            onPressed: () => openNoteBox(docID: docID),
                            icon: const Icon(Icons.settings)),
                        IconButton(
                            onPressed: () => firestoreService.deleteNote(docID),
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
                });
          } else {
            return const Text('No data...');
          }
        },
      ),
    );
  }
}
