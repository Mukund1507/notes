import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '/const.dart';

class Note {
  final String id;
  final String title;
  final String body;
  final File? image;
  final TextStyle textStyle;
  final Priority priority;
  String? password;
  Note({
    required this.id,
    required this.body,
    this.title = '',
    this.priority = Priority.neutral,
    this.image,
    this.textStyle = const TextStyle(),
    this.password,
  });
  lockUnlockNote(String newPassword) {
    if (password == null) {
      password = newPassword;
    } else {
      if (newPassword == password) {
        password = null;
        // ignore: avoid_print
        print('Incorrect password');
      }
    }
  }
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
      Share.shareXFiles([xFile],
          text: 'NOTE: ${note.body}', subject: note.title);
    } else {
      Share.share('NOTE: ${note.body}', subject: note.title);
    }
  }
}
