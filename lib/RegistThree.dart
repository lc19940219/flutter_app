import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/pages/Tabs.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ApiManager.dart';
import 'service/Storage.dart';

class RegistThree extends StatefulWidget {
  Map arguments;

  RegistThree({this.arguments, Key key}) : super(key: key);

  @override
  _RegistThreeState createState() => _RegistThreeState();
}

class _RegistThreeState extends State<RegistThree> {
  String tel;
  String code;
  String password = '';
  String rpassword = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tel = widget.arguments["tel"];
    this.code = widget.arguments["code"];
  }

  Future<void> doRegister() async {
    if (this.password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码长度不能小于6位',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (this.password != this.rpassword) {
      Fluttertoast.showToast(
        msg: '密码和确认密码不一致',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${ApiManager.api}api/register';
      var response = await Dio().post(api, data: {
        "tel": this.tel,
        "code": this.code,
        "password": this.password
      });
      if (response.data["success"]) {
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));
        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>new Tabs()), (route) => route==null);
        //返回到根
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("注册3"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenAdapter.setWidth(20)),
        child: Column(
          children: <Widget>[
            JdTextFiled(
              labeltext: "密码",
              hinttext: "请输入密码",
              prefixicon: Icons.security,
              onchange: (value) {
                setState(() {
                  this.password = value;
                });
              },
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(40),
            ),
            JdTextFiled(
              labeltext: "确认密码",
              hinttext: "请再次输入密码",
              prefixicon: Icons.security,
              onchange: (value) {
                setState(() {
                  this.rpassword = value;
                });
              },
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(50),
            ),
            JDButton(
              color: Colors.red,
              str: "下一步",
              fun: doRegister,
            )
          ],
        ),
      ),
    );
  }
}
