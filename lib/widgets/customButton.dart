import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color fgColor;
  final Color bgColor;
  const customButton({Key? key, required this.text, required this.onTap, required this.fgColor, required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: fgColor,
          backgroundColor: bgColor,
          padding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
        ),
    );
  }
}
