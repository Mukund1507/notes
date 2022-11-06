import 'package:flutter/material.dart';

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

  final List<Color> colors = const [
    Colors.orange,
    Colors.purple,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.brown,
    Colors.blueGrey,
    Colors.red,
    Colors.black,
  ];
  final List<double> sizes = const [
    12,
    14,
    16,
    18,
    20,
  ];

  double fontSize = 14;
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;
  TextDecoration textDecoration = TextDecoration.none;

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
                child: TextField(
                  maxLines: 100,
                  minLines: 1,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontStyle: fontStyle,
                    decoration: textDecoration,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: fontSize,
                      fontStyle: fontStyle,
                      decoration: textDecoration,
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
                      (current) => StyleOptionColorButton(color: current),
                    )
                    .toList(),
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
  const StyleOptionButton(
      {super.key,
      required this.text,
      required this.isSelected,
      this.bold = false,
      this.italics = false,
      this.underline = false,
      required this.onTap});
  final String text;
  final bool bold;
  final bool italics;
  final bool underline;
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

class StyleOptionColorButton extends StatelessWidget {
  const StyleOptionColorButton({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: FittedBox(
            child: Container(
              color: color,
              height: 14,
              width: 14,
            ),
          ),
        ),
      ),
    );
  }
}
