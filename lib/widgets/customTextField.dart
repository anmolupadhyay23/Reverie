import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData iconName;

  const customTextField({Key? key, required this.controller, required this.hintText, required this.obscureText, required this.iconName,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black
      ),
      obscureText: obscureText,
      controller: controller,

      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            iconName,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2.0
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 5
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
    );
  }
}
