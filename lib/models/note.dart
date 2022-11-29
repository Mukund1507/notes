import 'package:flutter/cupertino.dart';

class Note {
  final String id;
  String title;
  final String body;
  Note({required this.id, this.title = '', required this.body});
}

class Notes with ChangeNotifier {
  List<Note> notesList = [];

  void saveNote(Note note) {
    var temp = notesList.indexWhere((current) => current.id == note.id);
    if (temp == -1) {
      notesList.add(note);
    } else {
      notesList.removeAt(temp);
      notesList.insert(temp, note);
    }
    notifyListeners();
  }
}
