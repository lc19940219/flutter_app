import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/Storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ApiManager.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  doLogin() async {
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (!reg.hasMatch(this.username)) {
      Fluttertoast.showToast(
          msg: "手机号格式不对",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT);
    } else if (this.password.length < 6) {
      Fluttertoast.showToast(
          msg: "密码不正确",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      var api = '${ApiManager.api}api/doLogin';
      var resopnse = await Dio().post(api,
          data: {"username": this.username, "password": this.password});
      if (resopnse.data["success"]) {
        Storage.setString("userInfo", json.encode(resopnse.data["userinfo"]));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: "${resopnse.data["message"]}",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(ScreenAdapter.setWidth(20)),
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenAdapter.setHeight(160),
                  width: ScreenAdapter.setWidth(160),
                  child: Image.asset(
                    "images/login.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: ScreenAdapter.setHeight(90),
                ),
                JdTextFiled(
                  labeltext: "用户名",
                  hinttext: "请输入用户名",
                  prefixicon: Icons.security,
                  onchange: (value) {
                    setState(() {
                      this.username = value;
                    });
                  },
                ),
                SizedBox(
                  height: ScreenAdapter.setHeight(80),
                ),
                JdTextFiled(
                  labeltext: "密码",
                  hinttext: "请输入密码",
                  obscureText: true,
                  prefixicon: Icons.security,
                  onchange: (value) {
                    setState(() {
                      this.password = value;
                    });
                  },
                ),
                SizedBox(
                  height: ScreenAdapter.setHeight(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Text("忘记密码"),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text("注册"),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenAdapter.setHeight(30),
                ),
                Container(
                  child: JDButton(
                    color: Colors.red,
                    str: "登录",
                    height: 90.0,
                    fun: doLogin,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
