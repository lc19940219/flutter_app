import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/pages/CheckOutProvide.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'ApiManager.dart';
import 'SignService.dart';
import 'service/UserServices.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List _addressList = [];
  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaddress();
  }

  getaddress() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};
    var sign = SignService.getSign(tempJson);
    var api =
        "${ApiManager.api}/api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}";
    var response = await Dio().get(api);
    setState(() {
      this._addressList = response.data["result"];
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    CheckOutProvide checkOutProvide = Provider.of<CheckOutProvide>(context);
    this.list = checkOutProvide.checkoutList;
    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            this._addressList.length > 0
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/AddressListPage");
                    },
                    child: ListTile(
                      leading: Icon(Icons.local_activity),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("11111"),
                          SizedBox(
                            height: ScreenAdapter.setHeight(30),
                          ),
                          Text("11111"),
                        ],
                      ),
                      trailing: Icon(Icons.more),
                    ),
                  )
                : InkWell(
                    child: ListTile(
                      leading: Icon(Icons.local_activity),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text("请添加地址")],
                      ),
                      trailing: Icon(Icons.more),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/AddressAddPage",
                          arguments: {"isEdit": false});
                    },
                  ),
            Divider(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(bottom: ScreenAdapter.setHeight(110)),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: ScreenAdapter.setHeight(250),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.all(ScreenAdapter.setWidth(10)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: ScreenAdapter.setHeight(220),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            ScreenAdapter.setWidth(10)),
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: "${this.list[index]['pic']}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: ScreenAdapter.setHeight(220),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 5),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "${this.list[index]['title']}",
                                              maxLines: 2,
                                            ),
                                            Text(
                                                "属性:${this.list[index]['selectValue']}"),
                                            Stack(
                                              children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "￥${this.list[index]['price']}",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      "x${this.list[index]['count']}",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ),
                                              ],
                                            )
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: ScreenAdapter.setHeight(10),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: this.list.length,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: ScreenAdapter.setHeight(110),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "合计:￥${checkOutProvide.allPrice}",
                            style: TextStyle(color: Colors.red),
                          ),
                          Container(
                            width: ScreenAdapter.setWidth(200),
                            child: JDButton(
                              color: Colors.red,
                              fun: () {
                                Navigator.pushNamed(context, "/PayPage");
                              },
                              str: "结算",
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(color: Colors.black26, width: 1))),
                    ),
                    bottom: 0,
                  )
                ],
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
