import 'package:flutter/material.dart';

class productTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const productTextField({Key? key, required this.controller, required this.hintText, this.maxLines=1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(
          color: Colors.black
      ),
      controller: controller,

      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.black
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1.0
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.zero
          )
      ),
      validator: (val) {
        if(val==null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
