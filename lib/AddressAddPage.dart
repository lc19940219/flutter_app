import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/EventBus.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/UserServices.dart';
import 'package:transparent_image/transparent_image.dart';

import 'ApiManager.dart';
import 'SignService.dart';

class AddressAddPage extends StatefulWidget {
  Map arguments;

  AddressAddPage({
    Key key,
    this.arguments,
  }) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.isEdit = widget.arguments['isEdit'];

    if (isEdit) {
      this.name = widget.arguments['name'];
      this.phone = widget.arguments['phone'];
      this.address = widget.arguments['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: !this.isEdit ? Text("增加") : Text("修改"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenAdapter.setWidth(20)),
        child: ListView(
          children: <Widget>[
            JdTextFiled(
              labeltext: "姓名",
              hinttext: "请输入姓名",
              onchange: (value) {
                // setState(() {
                this.name = value;
                // });
              },
              prefixicon: Icons.people,
              controller: TextEditingController.fromValue(TextEditingValue(
                text: this.name,
                selection: TextSelection.fromPosition(TextPosition(
                  offset: this.name.length,
                  affinity: TextAffinity.downstream,
                )),
              )),
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            JdTextFiled(
              labeltext: "手机号",
              hinttext: "请输入手机号",
              onchange: (value) {
                // setState(() {
                this.phone = value;
                // });
              }, controller: TextEditingController.fromValue(TextEditingValue(
              text: this.phone,
              selection: TextSelection.fromPosition(TextPosition(
                offset: this.phone.length,
                affinity: TextAffinity.downstream,
              )),
            )),
              prefixicon: Icons.people,
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            InkWell(
              onTap: () async {
                Result result =
                    await CityPickers.showFullPageCityPicker(context: context);
//                        cancelWidget: Text("取消"),
//                        confirmWidget: Text("确定"));
                print(result);
                setState(() {
                  this.area =
                      "${result.provinceName}/${result.cityName}/${result.areaName}";
                });
              },
              child: ListTile(
                title:
                    this.area.length > 0 ? Text("${this.area}") : Text("省/市/区"),
                leading: Icon(Icons.local_activity),
              ),
            ),
            Divider(),
            JdTextFiled(
              labeltext: "详细地址",
              hinttext: "请输入详细地址",
              maxlines: 10,
              height: ScreenAdapter.setHeight(500),
              onchange: (value) {
                this.address = value;
              },
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(100),
            ),
            FlatButton(
              onPressed: this.isEdit ? _editAddress : addAddress,
              child: this.isEdit ? Text("更新") : Text("新增"),
              color: Colors.red,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  void addAddress() async {
    List userinfo = await UserServices.getUserInfo();
    Map tempMap = {
      "uid": userinfo[0]["_id"],
      "name": this.name,
      "phone": this.phone,
      "address": "${this.area} ${this.address}",
      "salt": userinfo[0]["salt"]
    };
    String sign = SignService.getSign(tempMap);
    var api = '${ApiManager.api}api/addAddress';
    var response = await Dio().post(api, data: {
      "uid": userinfo[0]["_id"],
      "name": this.name,
      "phone": this.phone,
      "address": "${this.area} ${this.address}",
      "sign": sign
    });
    print("${response.data}");
    if (response.data["success"]) {
      Navigator.pop(context);
    }
  }

  void _editAddress() async{
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]["_id"],
      "id": widget.arguments["id"],
      "name": this.name,
      "phone": this.phone,
      "address": "${this.area} ${this.address}",
      "salt": userinfo[0]["salt"]
    };

    var sign = SignService.getSign(tempJson);
    // print(sign);

    var api = '${ApiManager.api}api/editAddress';
    var response = await Dio().post(api, data: {
      "uid": userinfo[0]["_id"],
      "id": widget.arguments["id"],
      "name": this.name,
      "phone": this.phone,
      "address": "${this.area} ${this.address}",
      "sign": sign
    });

    print(response);
    if (response.data["success"]) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventBus.fire(AddressEvent("增加成功"));
    eventBus.fire(CheckOutEvent("改收货地址成功"));
  }
}
