import 'package:flutter/material.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenAdapter.setHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
              child: Text("加载中"),
            )
          ],
        ),
      ),
    );
  }
}
