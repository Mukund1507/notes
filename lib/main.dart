import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotePage(),
    );
  }
}

enum SelectedStyleButtonOptions {
  textStyle,
  textSize,
  textColor,
  none,
}

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final appBarHeight = height * 0.1;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.description_outlined),
        title: const Text('Simple Notes'),
        toolbarHeight: appBarHeight,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, appBarHeight * 0.6),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 40, left: 40),
            child: TextField(
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 24),
              controller: _titleController,
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
                child: const TextField(
                  maxLines: 100,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
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
                children: const [
                  StyleOptionButton(
                      text: 'BOLD', bold: true, isSelected: false),
                  StyleOptionButton(
                      text: 'ITALICS', italics: true, isSelected: false),
                  StyleOptionButton(
                      text: 'UNDERLINE', underline: true, isSelected: false),
                ],
              ),
            ),
          if (selectedStyleButtonOptions == SelectedStyleButtonOptions.textSize)
            Material(
              elevation: 5,
              child: Row(
                children: const [
                  StyleOptionButton(text: '12PX', isSelected: false),
                  StyleOptionButton(text: '14PX', isSelected: false),
                  StyleOptionButton(text: '16PX', isSelected: false),
                  StyleOptionButton(text: '18PX', isSelected: false),
                  StyleOptionButton(text: '20PX', isSelected: false),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class StyleButton extends StatelessWidget {
  const StyleButton(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onTap});
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: FittedBox(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: (isSelected)
                          ? Theme.of(context).primaryColor
                          : Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            (isSelected)
                ? Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 4,
                    height: 4,
                  )
                : const Divider(
                    color: Colors.white,
                    thickness: 4,
                    height: 4,
                  ),
          ],
        ),
      ),
    );
  }
}

class StyleOptionButton extends StatelessWidget {
  const StyleOptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.bold = false,
    this.italics = false,
    this.underline = false,
  });
  final String text;
  final bool bold;
  final bool italics;
  final bool underline;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              color: Colors.grey.withOpacity(0.3),
              padding: const EdgeInsets.all(10),
              child: Center(
                child: FittedBox(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: (isSelected)
                          ? Theme.of(context).primaryColor
                          : Colors.black54,
                      fontWeight: (bold) ? FontWeight.bold : FontWeight.w600,
                      fontStyle:
                          (italics) ? FontStyle.italic : FontStyle.normal,
                      decoration: (underline)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
