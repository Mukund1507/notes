import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notes/const.dart';

class Note {
  final String id;
  final String title;
  final String body;
  final File? image;
  final TextStyle textStyle;
  Note({
    required this.id,
    this.title = '',
    required this.body,
    this.image,
    this.textStyle = const TextStyle(),
  });
}

class Notes with ChangeNotifier {
  List<Note> notesList = [];

  void saveNote(Note note, Priority priority) {
    var temp = notesList.indexWhere((current) => current.id == note.id);
    if (temp == -1) {
      if (priority == Priority.high) {
        notesList.insert(0, note);
      } else {
        notesList.add(note);
      }
    } else {
      notesList.removeAt(temp);
      if (priority == Priority.neutral) {
        notesList.insert(temp, note);
      } else if (priority == Priority.high) {
        notesList.insert(0, note);
      } else {
        notesList.add(note);
      }
    }
    notifyListeners();
  }
}
