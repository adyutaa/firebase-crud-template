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
  void openNoteBox() {
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
                      firestoreService.addNote(textController.text);
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
          title: Text("Notes"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openNoteBox,
          child: Icon(Icons.add),
        ));
  }
}
