import 'package:flutter/material.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

class JDButton extends StatefulWidget {
  var color;
  var str;
  var fun;
  var height;

  JDButton(
      {Key key,
      this.color = Colors.yellow,
      this.str = "按钮",
      this.fun = null,
      this.height = 78.0})
      : super(key: key);

  @override
  _JDButtonState createState() => _JDButtonState();
}

class _JDButtonState extends State<JDButton> {

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
        height: ScreenAdapter.setHeight(this.widget.height),
        margin: EdgeInsets.all(ScreenAdapter.setWidth(5)),
        padding: EdgeInsets.all(ScreenAdapter.setHeight(5)),

        decoration: BoxDecoration(color: this.widget.color,
        borderRadius: BorderRadius.all(Radius.circular(ScreenAdapter.setHeight(10)))),
        child: FlatButton(
          onPressed: this.widget.fun,
          child: Text(this.widget.str),
          textColor: Colors.white,
        ));
  }
}
