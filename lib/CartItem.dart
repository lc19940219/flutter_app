import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    CartProvide cartProvide = Provider.of<CartProvide>(context);
    ScreenAdapter.init(context);

    return Container(
      height: ScreenAdapter.setHeight(220),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black54, width: 1))),
      child: Row(
        children: <Widget>[
          Container(
            child: Checkbox(
              value: false,
              onChanged: (value) {},
              activeColor: Colors.red,
            ),
          ),
Container(
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "null"),
  ),
)
        ],
      ),
    );
  }
}
