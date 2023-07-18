import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddToCartButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color fgColor;
  final Color bgColor;
  final double textSize;
  final IconData icon;
  const AddToCartButton({Key? key, required this.text, required this.onTap, required this.fgColor, required this.bgColor, required this.textSize, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              size: 15,
            ),
          )
        ],
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
