import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

import 'ApiManager.dart';

class RegistTwo extends StatefulWidget {
  Map arguments;

  RegistTwo({this.arguments, Key key}) : super(key: key);

  @override
  _RegistTwoState createState() => _RegistTwoState();
}

class _RegistTwoState extends State<RegistTwo> {
  String _tel;
  String _yzm;
  bool sendCodeBtn = false;
  int seconds = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._tel = widget.arguments["tel"];
    _showTime();
  }

  Timer t;

  void _showTime() {
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        setState(() {
          this.seconds--;
        });
      }

      if (this.seconds == 0) {t.cancel();
      if (mounted) {
          setState(() {
            this.sendCodeBtn = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (t != null) {
      t.cancel();
    }
  }

  void sendCode() async {
    setState(() {
      this.seconds = 10;
      this.sendCodeBtn = false;
      this._showTime();
    });
    var api = "${ApiManager.api}api/sendCode";
    var response = await Dio().post(api, data: {"tel": this._tel});
    if (response.data["success"]) {
      print(response); //演示期间服务器直接返回  给手机发送的验证码
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("注册2"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenAdapter.setWidth(20)),
        child: Column(
          children: <Widget>[
            Text("验证码已经发送到了您的${this._tel}手机，请输${this._tel}手机号收到的验证码"),
            SizedBox(
              height: ScreenAdapter.setHeight(40),
            ),
            Stack(
              children: <Widget>[
                JdTextFiled(
                  labeltext: "验证码",
                  hinttext: "请输入验证码",
                  prefixicon: Icons.security,
                  onchange: (value) {
                    setState(() {
                      this._yzm = value;
                    });
                  },
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: this.sendCodeBtn
                      ? RaisedButton(
                          child: Text("重新获取验证码"),
                          color: Colors.red,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: sendCode,
                        )
                      : RaisedButton(
                          child: Text("${this.seconds}后重新获取验证码"),
                          color: Colors.red,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                        ),
                )
              ],
            ),
            JDButton(
              color: Colors.red,
              fun: () {},
              height: 100.0,
              str: "下一步",
            )
          ],
        ),
      ),
    );
  }
}
