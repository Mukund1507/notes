import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notes/const.dart';

class Note {
  final String id;
  final String title;
  final String body;
  final File? image;
  final TextStyle textStyle;
  final Priority priority;
  Note({
    required this.id,
    required this.body,
    this.title = '',
    this.priority = Priority.neutral,
    this.image,
    this.textStyle = const TextStyle(),
  });
}

class Notes with ChangeNotifier {
  List<Note> notesList = [];
  List<Note> highPriorityNotesList = [];
  List<Note> lowPriorityNotesList = [];
  List<Note> neutralPriorityNotesList = [];

  void saveNote(Note note, Priority priority) {
    var temp = notesList.indexWhere((current) => current.id == note.id);
    if (temp == -1) {
      notesList.add(note);
      if (priority == Priority.high) {
        highPriorityNotesList.add(note);
      } else if (priority == Priority.neutral) {
        neutralPriorityNotesList.add(note);
      } else if (priority == Priority.low) {
        lowPriorityNotesList.add(note);
      }
    } else {
      notesList.removeAt(temp);
      notesList.insert(temp, note);
      highPriorityNotesList.removeWhere((current) => current.id == note.id);
      neutralPriorityNotesList.removeWhere((current) => current.id == note.id);
      lowPriorityNotesList.removeWhere((current) => current.id == note.id);
      if (priority == Priority.high) {
        highPriorityNotesList.add(note);
      } else if (priority == Priority.neutral) {
        neutralPriorityNotesList.add(note);
      } else if (note.priority == Priority.low) {
        lowPriorityNotesList.add(note);
      }
    }
    notifyListeners();
  }
}
