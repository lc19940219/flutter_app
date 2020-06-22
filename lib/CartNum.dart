import 'package:flutter/material.dart';
import 'package:flutterapp/model/ProductContentModel.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartNum extends StatefulWidget {
  ProductContentItem productContentItem;

  CartNum(this.productContentItem);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  var _count;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this._count = this.widget.productContentItem.count ?? 1;
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (this._count == 1) {
                Fluttertoast.showToast(
                    msg: "不能再减了",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.red);

              }else{
                setState(() {
                  this._count--;
                  this.widget.productContentItem.count = this._count;
                });
              }

            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenAdapter.setWidth(55),
              height: ScreenAdapter.setHeight(55),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenAdapter.setWidth(5)),
                      bottomLeft: Radius.circular(ScreenAdapter.setWidth(5)))),
              child: Text("-"),
            ),
          ),
          Container(
            width: ScreenAdapter.setWidth(80),
            height: ScreenAdapter.setHeight(55),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black26, width: 1),
                    bottom: BorderSide(color: Colors.black26, width: 1))),
            child: Text("${this._count}"),
          ),
          InkWell(
            onTap: () {
              setState(() {
                this._count++;
                this.widget.productContentItem.count = this._count;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenAdapter.setWidth(55),
              height: ScreenAdapter.setHeight(55),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(ScreenAdapter.setWidth(5)),
                      bottomRight: Radius.circular(ScreenAdapter.setWidth(5)))),
              child: Text("+"),
            ),
          ),
        ],
      ),
    );
  }
}
