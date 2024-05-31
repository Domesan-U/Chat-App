import 'package:flutter/material.dart';
import 'login_screen.dart';
class rounded_button extends StatelessWidget {
  rounded_button({this.colour,this.title, required this.onPressed });
  final Color? colour;
  final String? title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(40.0),
      color: colour,
      child: MaterialButton(onPressed: () {this.onPressed();}, child: Text(this.title??'',style: TextStyle(color: Colors.white))),
    );
  }
}
