import 'dart:io';

import 'package:flutter/cupertino.dart';

class Note {
  final String id;
  final String title;
  final String body;
  final File? image;
  Note({required this.id, this.title = '', required this.body, this.image});
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
