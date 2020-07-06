import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ApiManager.dart';

class RegistFirst extends StatefulWidget {
  @override
  _RegistFirstState createState() => _RegistFirstState();
}

class _RegistFirstState extends State<RegistFirst> {
  String _tel = '';
  Future<void> toNext
      () async {
    print("tonext");
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(this._tel)) {
      var api = '${ApiManager.api}api/sendCode';
      var respone = await Dio().post(api, data: {"tel": this._tel});
      print(respone);
      if (respone.data['success']) {
        Navigator.pushNamed(context, "/RegistTwo",
            arguments: {"tel": this._tel});
      }else{
        Fluttertoast.showToast(
          msg: '${respone.data['message']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
    else {
      Fluttertoast.showToast(
        msg: '请输入正确的电话号码',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("注册1"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenAdapter.setWidth(20)),
        child: Column(
          children: <Widget>[
            JdTextFiled(
              labeltext: "手机号",
              prefixicon: Icons.phone,
              hinttext: "请输入手机号",
              obscureText: false,
              onchange: (value) {
                setState(() {
                  this._tel = value;
                });
              },
            ),
            SizedBox(height: ScreenAdapter.setHeight(50)),
            JDButton(
              color: Colors.red,
              str: "下一步",
              fun: () {
                this.toNext();
              },
            )
          ],
        ),
      ),
    );
  }


}
