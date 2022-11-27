import 'package:flutter/material.dart';

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
  const StyleOptionColorButton(
      {super.key, required this.color, required this.onTap});
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
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
      ),
    );
  }
}
