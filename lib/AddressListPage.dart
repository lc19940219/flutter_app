import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/UserServices.dart';
import 'package:transparent_image/transparent_image.dart';

import 'EventBus.dart';
import 'SignService.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBus.on<AddressEvent>().listen((event) {
      getAddressData();
    });
    getAddressData();
  }

  void getAddressData() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};
    var sign = SignService.getSign(tempJson);

    var api =
        "${ApiManager.api}api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}";
    var respone = await Dio().get(api);
    setState(() {
      this.addressList = respone.data['result'];
    });
  }

  dispose() {
    super.dispose();
    eventBus.fire(new CheckOutEvent('改收货地址成功...'));
  }

  _showAlertDialog(id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息"),
            content: Text("您确定要删除吗"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //执行删除操作
                  this._delAddress(id);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  _delAddress(id) async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]["_id"],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignService.getSign(tempJson);

    var api = '${ApiManager.api}api/deleteAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]["_id"], "id": id, "sign": sign});
    this.getAddressData(); //
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("地址列表"),
        centerTitle: true,
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          this.addressList.length > 0
              ? ListView.builder(
                  padding:
                      EdgeInsets.only(bottom: ScreenAdapter.setHeight(110)),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: InkWell(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                  SizedBox(height: 10),
                                  Text("${this.addressList[index]["address"]}"),
                                ]),
                            onTap: () {
                              _changeDefaultAddress(
                                  this.addressList[index]["_id"]);
                            },
                            onLongPress: () {
                              this._showAlertDialog(
                                  this.addressList[index]["_id"]);
                            },
                          ),
                          leading:
                              this.addressList[index]["default_address"] == 1
                                  ? Icon(Icons.check, color: Colors.red)
                                  : null,
                          trailing: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/AddressEditPage");
                            },
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.pushNamed(context, "/AddressAddPage",
                                    arguments: {
                                      "isEdit": true,
                                      "id": this.addressList[index]["_id"],
                                      "name": this.addressList[index]["name"],
                                      "phone": this.addressList[index]["phone"],
                                      "address": this.addressList[index]
                                          ["address"],
                                    });
                              },
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: this.addressList.length,
                )
              : Center(
                  child: Text("请添加地址"),
                ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: ScreenAdapter.setHeight(110),
            child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "/AddressAddPage",
                    arguments: {"isEdit": false});
              },
              child: Text("新增"),
              textColor: Colors.white,
              color: Colors.red,
            ),
          )
        ],
      )),
    );
  }

  void _changeDefaultAddress(id) async {
    List userinfo = await UserServices.getUserInfo();

    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignService.getSign(tempJson);

    var api = '${ApiManager.api}api/changeDefaultAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});
    Navigator.pop(context);
  }
}
