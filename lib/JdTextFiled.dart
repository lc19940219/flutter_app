import 'package:flutter/material.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

class JdTextFiled extends StatelessWidget {
  String labeltext;
  String hinttext;
  double height;
  var prefixicon;
  var onchange;
  bool obscureText;
  var maxlines;
  TextEditingController controller;

  JdTextFiled(
      {this.labeltext = "",
      this.hinttext = "",
      this.height = 100.0,
      this.prefixicon = Icons.add,
      this.onchange = null,
      this.obscureText = false,
      this.maxlines = 1,
      this.controller = null});

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      height: ScreenAdapter.setHeight(this.height),
      child: TextField(
        controller: this.controller,
        autofocus: true,
        maxLines: this.maxlines,
        obscureText: this.obscureText,
        onChanged: this.onchange,
        decoration: InputDecoration(
            prefixIcon: Icon(this.prefixicon),
            labelText: this.labeltext,
            border: OutlineInputBorder(),
            hintText: this.hinttext),
      ),
    );
  }
}
