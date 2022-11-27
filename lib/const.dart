import 'package:flutter/material.dart';

const List<double> sizes = [
  12,
  14,
  16,
  18,
  20,
];

const List<Color> colors = [
  Colors.orange,
  Colors.purple,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.brown,
  Colors.blueGrey,
  Colors.red,
  Colors.black,
];

List<Map> menuOptionsMap = [
  {
    'value': MenuOptions.highlighter,
    'text': 'Highlighter',
    'icon': 'assets/icons/simple_note_icon_03.png'
  },
  {
    'value': MenuOptions.imageCapture,
    'text': 'Image capture',
    'icon': 'assets/icons/simple_note_icon_04.png'
  },
  {
    'value': MenuOptions.imageBrowse,
    'text': 'Image browse',
    'icon': 'assets/icons/simple_note_icon_05.png'
  },
  {
    'value': MenuOptions.voiceInput,
    'text': 'Voice input',
    'icon': 'assets/icons/simple_note_icon_06.png'
  },
  {
    'value': MenuOptions.notesReminder,
    'text': 'Notes reminder',
    'icon': 'assets/icons/simple_note_icon_07.png'
  },
  {
    'value': MenuOptions.notesSharing,
    'text': 'Notes sharing',
    'icon': 'assets/icons/simple_note_icon_08.png'
  },
  {
    'value': MenuOptions.lockUnlock,
    'text': 'Lock/Unlock',
    'icon': 'assets/icons/simple_note_icon_09.png'
  },
  {
    'value': MenuOptions.notesPriority,
    'text': 'Notes priority',
    'icon': 'assets/icons/simple_note_icon_10.png'
  },
  {
    'value': MenuOptions.reset,
    'text': 'Reset',
    'icon': 'assets/icons/simple_note_icon_11.png'
  },
  {
    'value': MenuOptions.save,
    'text': 'Save',
    'icon': 'assets/icons/simple_note_icon_12.png'
  },
];

enum MenuOptions {
  highlighter,
  imageCapture,
  imageBrowse,
  voiceInput,
  notesReminder,
  notesSharing,
  lockUnlock,
  notesPriority,
  reset,
  save,
}

enum SelectedStyleButtonOptions {
  textStyle,
  textSize,
  textColor,
  none,
}

enum TextStyleOptions {
  bold,
  italics,
  underline,
}
