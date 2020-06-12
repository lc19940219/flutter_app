import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/LoadingWidget.dart';
import 'file:///F:/flutter_Test/flutter_app/lib/ProductContentThreePage.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

import 'ProductContentFirstPage.dart';
import 'ProductContentTwoPage.dart';
import 'model/ProductContentModel.dart';

class ProductContent extends StatefulWidget {
  Map arguments;

  ProductContent({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  List<ProductContentItem> productContenyList = [];

  @override
  void initState() {
    super.initState();
    _getContentData();
  }

  void _getContentData() async {
    var api = '${ApiManager.api}api/pcontent?id=${widget.arguments['id']}';
    var response = await Dio().get(api);
    var productModel = ProductContentModel.fromJson(response.data);
    setState(() {
      this.productContenyList.add(productModel.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.setWidth(400),
                    child: TabBar(tabs: [
                      Tab(
                        text: "1",
                      ),
                      Tab(
                        text: "2",
                      ),
                      Tab(
                        text: "3",
                      )
                    ]),
                  )
                ],
              ),
              actions: <Widget>[
                PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[Text("搜索"), Icon(Icons.search)],
                      ),
                      value: '搜索',
                    ),
                    PopupMenuItem(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[Text("首页"), Icon(Icons.home)],
                      ),
                      value: '首页',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == "首页") {
                    } else {}
                  },
                )
              ],
            ),
            body: this.productContenyList.length > 0
                ? Stack(
                    children: <Widget>[
                      TabBarView(children: <Widget>[
                        ProductContentFirstPage(),
                        ProductContentTwoPage(),
                        ProductContentThreePage()
                      ]),
                    ],
                  )
                : LoadingWidget()));
  }
}
