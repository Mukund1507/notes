import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../models/note.dart';
import '../widgets/custom_buttons.dart';

class NotePage extends StatefulWidget {
  static const routeName = '/notepage';
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  SelectedStyleButtonOptions selectedStyleButtonOptions =
      SelectedStyleButtonOptions.none;

  chooseButton(SelectedStyleButtonOptions option) {
    if (selectedStyleButtonOptions == option) {
      setState(() {
        selectedStyleButtonOptions = SelectedStyleButtonOptions.none;
      });
    } else {
      setState(() {
        selectedStyleButtonOptions = option;
      });
    }
  }

  setTextStyleOfNote(TextStyleOptions textStyleOptions, FontWeight weight,
      FontStyle style, TextDecoration decoration) {
    if (textStyleOptions == TextStyleOptions.bold) {
      if (fontWeight == FontWeight.bold) {
        fontWeight = FontWeight.normal;
      } else {
        fontWeight = FontWeight.bold;
      }
    }
    if (textStyleOptions == TextStyleOptions.italics) {
      if (fontStyle == FontStyle.italic) {
        fontStyle = FontStyle.normal;
      } else {
        fontStyle = FontStyle.italic;
      }
    }
    if (textStyleOptions == TextStyleOptions.underline) {
      if (textDecoration == TextDecoration.underline) {
        textDecoration = TextDecoration.none;
      } else {
        textDecoration = TextDecoration.underline;
      }
    }
    setState(() {
      selectedStyleButtonOptions = SelectedStyleButtonOptions.none;
    });
  }

  setSizeOfText(double size) {
    setState(() {
      fontSize = size;
      selectedStyleButtonOptions = SelectedStyleButtonOptions.none;
    });
  }

  setColorOfText(Color color) {
    setState(() {
      fontColor = color;
      selectedStyleButtonOptions = SelectedStyleButtonOptions.none;
    });
  }

  setPriorityOfNote(Priority priority) {
    notePriority = priority;
    Navigator.of(context).pop();
  }

  double fontSize = 14;
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;
  Color fontColor = Colors.black;
  TextDecoration textDecoration = TextDecoration.none;
  Priority notePriority = Priority.neutral;
  bool firstCome = false;
  File? image;

  void reset() {
    _titleController.clear();
    _bodyController.clear();
    setState(() {
      image = null;
    });
  }

  void save(String id) {
    final notes = Provider.of<Notes>(context, listen: false);
    notes.saveNote(
      Note(
        id: id,
        title: _titleController.text,
        body: _bodyController.text,
        image: image,
        textStyle: TextStyle(
          color: fontColor,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration: textDecoration,
        ),
      ),
      notePriority,
    );
    Navigator.pop(context);
  }

  void pickImageFromGalleryOrCamera(bool fromCam) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = (fromCam)
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  void setArgs(Note args) {
    if (firstCome == false) {
      _titleController.text = args.title;
      _bodyController.text = args.body;
      image = args.image;
      fontSize = args.textStyle.fontSize ?? 14;
      fontWeight = args.textStyle.fontWeight ?? FontWeight.normal;
      fontColor = args.textStyle.color ?? Colors.black;
      textDecoration = args.textStyle.decoration ?? TextDecoration.none;
      fontStyle = args.textStyle.fontStyle ?? FontStyle.normal;
      firstCome = true;
    }
  }

  void showPriorityDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: [
            ListTile(
              onTap: () => setPriorityOfNote(Priority.high),
              title: Text(
                'High',
                style: TextStyle(
                  color: (notePriority == Priority.high)
                      ? Theme.of(context).primaryColor
                      : Colors.black87,
                ),
              ),
            ),
            ListTile(
              onTap: () => setPriorityOfNote(Priority.neutral),
              title: Text(
                'Neutral',
                style: TextStyle(
                  color: (notePriority == Priority.neutral)
                      ? Theme.of(context).primaryColor
                      : Colors.black87,
                ),
              ),
            ),
            ListTile(
              onTap: () => setPriorityOfNote(Priority.low),
              title: Text(
                'Low',
                style: TextStyle(
                  color: (notePriority == Priority.low)
                      ? Theme.of(context).primaryColor
                      : Colors.black87,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final appBarHeight = height * 0.1;
    final Note args = ModalRoute.of(context)!.settings.arguments as Note;
    setArgs(args);
    Widget popUpTile(String title, String icon) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(icon),
              color: Colors.black87,
              size: 50,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(title),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.description_outlined),
        title: const Text('Simple Notes'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => menuOptionsMap
                .map(
                  (val) => PopupMenuItem(
                    value: val['value'] as MenuOptions,
                    child: popUpTile(
                      val['text'],
                      val['icon'],
                    ),
                  ),
                )
                .toList(),
            offset: const Offset(0, 40),
            elevation: 2,
            onSelected: (value) {
              if (value == MenuOptions.reset) {
                reset();
              }
              if (value == MenuOptions.save &&
                  _bodyController.text.isNotEmpty) {
                save(args.id);
              }
              if (value == MenuOptions.imageBrowse) {
                pickImageFromGalleryOrCamera(false);
              }
              if (value == MenuOptions.imageCapture) {
                pickImageFromGalleryOrCamera(true);
              }
              if (value == MenuOptions.notesPriority) {
                showPriorityDialog();
              }
            },
          ),
        ],
        toolbarHeight: appBarHeight,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, appBarHeight * 0.6),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 40, left: 40),
            child: TextField(
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 24),
              controller: _titleController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Title',
                labelText: 'Title',
                hintStyle: TextStyle(color: Colors.white, fontSize: 24),
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                alignLabelWithHint: false,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              elevation: 3,
              margin: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 15.0,
                  bottom: (selectedStyleButtonOptions !=
                          SelectedStyleButtonOptions.none)
                      ? 0
                      : 15.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: (image != null)
                      ? DecorationImage(
                          image: Image.file(image!).image, fit: BoxFit.cover)
                      : null,
                ),
                child: TextField(
                  maxLines: 100,
                  minLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  controller: _bodyController,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontStyle: fontStyle,
                    color: fontColor,
                    decoration: textDecoration,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      color: (fontColor == Colors.black)
                          ? Colors.black54
                          : fontColor,
                      fontSize: fontSize,
                      fontStyle: fontStyle,
                      decoration: textDecoration,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            elevation: 5,
            child: Row(
              children: [
                StyleButton(
                  text: 'TEXT STYLE',
                  isSelected: (selectedStyleButtonOptions ==
                      SelectedStyleButtonOptions.textStyle),
                  onTap: () =>
                      chooseButton(SelectedStyleButtonOptions.textStyle),
                ),
                StyleButton(
                  text: 'TEXT SIZE',
                  isSelected: (selectedStyleButtonOptions ==
                      SelectedStyleButtonOptions.textSize),
                  onTap: () =>
                      chooseButton(SelectedStyleButtonOptions.textSize),
                ),
                StyleButton(
                  text: 'TEXT COLOR',
                  isSelected: (selectedStyleButtonOptions ==
                      SelectedStyleButtonOptions.textColor),
                  onTap: () =>
                      chooseButton(SelectedStyleButtonOptions.textColor),
                ),
              ],
            ),
          ),
          if (selectedStyleButtonOptions ==
              SelectedStyleButtonOptions.textStyle)
            Material(
              elevation: 5,
              child: Row(
                children: [
                  StyleOptionButton(
                    text: 'BOLD',
                    bold: true,
                    isSelected: (fontWeight == FontWeight.bold),
                    onTap: () => setTextStyleOfNote(TextStyleOptions.bold,
                        FontWeight.bold, fontStyle, textDecoration),
                  ),
                  StyleOptionButton(
                    text: 'ITALICS',
                    italics: true,
                    isSelected: (fontStyle == FontStyle.italic),
                    onTap: () => setTextStyleOfNote(TextStyleOptions.italics,
                        fontWeight, FontStyle.italic, textDecoration),
                  ),
                  StyleOptionButton(
                    text: 'UNDERLINE',
                    underline: true,
                    isSelected: (textDecoration == TextDecoration.underline),
                    onTap: () => setTextStyleOfNote(TextStyleOptions.underline,
                        fontWeight, fontStyle, TextDecoration.underline),
                  ),
                ],
              ),
            ),
          if (selectedStyleButtonOptions == SelectedStyleButtonOptions.textSize)
            Material(
              elevation: 5,
              child: Row(
                children: sizes
                    .map(
                      (current) => StyleOptionButton(
                        text: '${current.toInt()} PX',
                        isSelected: (fontSize == current),
                        onTap: () => setSizeOfText(current),
                      ),
                    )
                    .toList(),
              ),
            ),
          if (selectedStyleButtonOptions ==
              SelectedStyleButtonOptions.textColor)
            Material(
              elevation: 5,
              child: Row(
                children: colors
                    .map(
                      (current) => StyleOptionColorButton(
                        color: current,
                        onTap: () => setColorOfText(current),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
