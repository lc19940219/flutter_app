import 'package:flutter/material.dart';
import 'package:flutterapp/CartNum.dart';
import 'package:flutterapp/CartProvide.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CartItem extends StatefulWidget {
  Map _itemData;

  CartItem(this._itemData, {Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;
  @override
  Widget build(BuildContext context) {
    CartProvide cartProvide = Provider.of<CartProvide>(context);
    ScreenAdapter.init(context);
    this._itemData = widget._itemData;
    return Container(
      height: ScreenAdapter.setHeight(220),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black54, width: 1))),
      child: Row(
        children: <Widget>[
          Container(
            child: Checkbox(
              value: this._itemData["checked"],
              onChanged: (value) {
                this._itemData["checked"] = !this._itemData["checked"];
                cartProvide.itemChange();
              },
              activeColor: Colors.red,
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: "${this._itemData["pic"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${this._itemData["title"]}",
                  maxLines: 2,
                ),
                Text("属性:${this._itemData["selectValue"]}"),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("￥${this._itemData["price"]}",
                          style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CartNum(this._itemData),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
