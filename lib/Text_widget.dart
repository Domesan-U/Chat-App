import 'dart:ffi';

import 'package:flutter/material.dart';
class Text_widget extends StatelessWidget {
  Text_widget({required this.hintText, required this.onChanged, this.value});
  final  void Function(String) onChanged;
  final String hintText;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: value??false,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: this.hintText,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(
            color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0),
          ),),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
