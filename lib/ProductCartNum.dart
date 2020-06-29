import 'package:flutter/material.dart';

import 'model/ProductContentModel.dart';
import 'service/ScreenAdapter.dart';


class ProductCartNum extends StatefulWidget {
  ProductContentItem _productContentItem;
  ProductCartNum(this._productContentItem, {Key key}) : super(key: key);

  @override
  _ProductCartNumState createState() => _ProductCartNumState();
}

class _ProductCartNumState extends State<ProductCartNum> {
  ProductContentItem _productContentItem;
  var _count=1;

  @override
  Widget build(BuildContext context) {
    this._productContentItem = widget._productContentItem;
    this._productContentItem.count=this._count;
    ScreenAdapter.init(context);
    return Container(
      width: ScreenAdapter.setWidth(170),
      decoration: BoxDecoration(
          border:
          Border.all(color: Color.fromRGBO(233, 233, 233, 0.8), width: 1)),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (this._count > 1) {
                setState(() {
                  this._count--;
                  this._productContentItem.count=this._count;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenAdapter.setWidth(45),
              height: ScreenAdapter.setHeight(45),
              child: Text("-"),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: ScreenAdapter.setHeight(45),
              alignment: Alignment.center,
              width: ScreenAdapter.setWidth(70),
              child: Text("${this._count}"),
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Color.fromRGBO(233, 233, 233, 0.8), width: 1),
                    right: BorderSide(
                        color: Color.fromRGBO(233, 233, 233, 0.8), width: 1),
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                this._count++;
                this._productContentItem.count=this._count;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenAdapter.setWidth(45),
              height: ScreenAdapter.setHeight(45),
              child: Text("+"),
            ),
          )
        ],
      ),
    );
  }
}
