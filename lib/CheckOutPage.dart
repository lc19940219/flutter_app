import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List _addressList = [];

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
                    onTap: () {},
                    child: Text("1"),
                  )
                : InkWell(
                    onTap: () {},
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
                  ),
            Divider(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    margin:
                        EdgeInsets.only(bottom: ScreenAdapter.setHeight(110)),
                  ),
                  Positioned(
                    child: Container(
                      height: ScreenAdapter.setHeight(110),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("合计"),
                          Container(
                            width: ScreenAdapter.setWidth(200),
                            child: JDButton(
                              color: Colors.red,
                              fun: () {},
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
