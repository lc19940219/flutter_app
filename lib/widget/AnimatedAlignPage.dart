import 'package:flutter/material.dart';

class AnimatedAlignPage extends StatefulWidget {
  @override
  _AnimatedAlignPageState createState() => _AnimatedAlignPageState();
}

class _AnimatedAlignPageState extends State<AnimatedAlignPage> {
  Alignment _alignment = Alignment.topLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: 200,
      height: 200,
      color: Colors.lightBlue,
      child: AnimatedAlign(
        alignment: _alignment,
        duration: Duration(seconds: 2),
        child: IconButton(
          icon: Icon(
            Icons.print,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              _alignment = Alignment.bottomRight;
            });
          },
        ),
      ),
    ),);
  }
}
