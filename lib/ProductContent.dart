import 'package:flutter/material.dart';

class ProductContent extends StatefulWidget {
  Map arguments;

  ProductContent({Key key,this.arguments}):super(key:key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情"),

      ),
      body: Text(widget.arguments["id"]),

    );
  }
}
