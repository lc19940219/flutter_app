import 'package:flutter/material.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: ScreenAdapter.setHeight(302),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(ScreenAdapter.setWidth(350))),
                    ),
                  ),
                  Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Container(
                        height: ScreenAdapter.setHeight(300),

                        color: Colors.red,
                      ),
                      Container(
                        height: ScreenAdapter.setHeight(300),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(ScreenAdapter.setWidth(360))),
                        ),
                      ),
                    ],
                  )
                ],
              ),

            ],
          ),
        ));
  }
}
