import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/UserServices.dart';
import 'package:transparent_image/transparent_image.dart';

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
    getAddressData();
  }

  getAddressData() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};
    var sign = SignService.getSign(tempJson);
    var api =
        "${ApiManager.api}/api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}";
    var response = await Dio().get(api);
    setState(() {
      this.addressList = response.data["result"];
    });
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
              ? Expanded(
                  child: ListView.builder(
                  padding:
                      EdgeInsets.only(bottom: ScreenAdapter.setHeight(110)),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                          subtitle:
                              Text("${this.addressList[index]["address"]} "),
                          leading:
                              this.addressList[index]["default_address"] == 1
                                  ? Icon(Icons.check, color: Colors.red)
                                  : kTransparentImage,
                          trailing: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/AddressEditPage");
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: this.addressList.length,
                ))
              : Center(
                  child: Text("请添加地址"),
                ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: ScreenAdapter.setHeight(110),
            child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "/AddressAddPage");
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
}
