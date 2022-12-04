import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notes/const.dart';
import 'package:share_plus/share_plus.dart';

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

  void saveNote(Note note) {
    var temp = notesList.indexWhere((current) => current.id == note.id);
    if (temp == -1) {
      notesList.add(note);
      if (note.priority == Priority.high) {
        highPriorityNotesList.add(note);
      } else if (note.priority == Priority.neutral) {
        neutralPriorityNotesList.add(note);
      } else if (note.priority == Priority.low) {
        lowPriorityNotesList.add(note);
      }
    } else {
      notesList.removeAt(temp);
      notesList.insert(temp, note);
      highPriorityNotesList.removeWhere((current) => current.id == note.id);
      neutralPriorityNotesList.removeWhere((current) => current.id == note.id);
      lowPriorityNotesList.removeWhere((current) => current.id == note.id);
      if (note.priority == Priority.high) {
        highPriorityNotesList.add(note);
      } else if (note.priority == Priority.neutral) {
        neutralPriorityNotesList.add(note);
      } else if (note.priority == Priority.low) {
        lowPriorityNotesList.add(note);
      }
    }
    notifyListeners();
  }

  void shareNote(Note note) {
    saveNote(note);
    if (note.image != null) {
      XFile xFile = XFile(note.image!.path);
      Share.shareXFiles([xFile], text: note.body, subject: note.title);
    } else {
      Share.share(note.body, subject: note.title);
    }
  }
}
