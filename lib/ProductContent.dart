import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/CartProvide.dart';
import 'package:flutterapp/CartService.dart';
import 'package:flutterapp/EventBus.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/LoadingWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Cart.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:provider/provider.dart';

import 'ProductContentFirstPage.dart';
import 'ProductContentThreePage.dart';
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
  CartProvide cartProvide;

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
    cartProvide = Provider.of<CartProvide>(context);
    Cart cart = Provider.of<Cart>(context);
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
                        text: "商品",
                      ),
                      Tab(
                        text: "详情",
                      ),
                      Tab(
                        text: "评论",
                      )
                    ]),
                  )
                ],
              ),
              actions: <Widget>[
                PopupMenuButton(
                  itemBuilder: (context) =>
                  <PopupMenuEntry<String>>[
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
                      Navigator.pushNamed(context, "/");
                    } else {
                      Navigator.pushNamed(context, "/SearchPage");
                    }
                  },
                )
              ],
            ),
            body: this.productContenyList.length > 0
                ? Stack(
              children: <Widget>[
                TabBarView(
                  children: <Widget>[
                    ProductContentFirstPage(this.productContenyList),
                    ProductContentTwoPage(this.productContenyList),
                    ProductContentThreePage()
                  ],
                  physics: NeverScrollableScrollPhysics(),
                ),
                Positioned(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: ScreenAdapter.setHeight(120),
                    padding: EdgeInsets.all(10),
//                          margin: EdgeInsets.only(
//                              top: ScreenAdapter.setHeight(120)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: Colors.black26, width: 1))),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: ScreenAdapter.setWidth(120),
                            height: ScreenAdapter.setHeight(100),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  size: 23,
                                ),
                                Text("购物车")
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: JDButton(
                            color: Colors.yellow,
                            str: "加入购物车",
                            fun: () async {
                              if (this.productContenyList[0].attr.length >
                                  0) {
                                eventBus
                                    .fire(ProductContentEvent("加入购物车"));
                              } else {
                                await CartService.add(
                                    this.productContenyList[0]);
                                cartProvide.updata();
                                cart.increment();
                                Fluttertoast.showToast(
                                    msg: "加入购物车成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: JDButton(
                            color: Colors.red,
                            str: "立即购买",
                            fun: (){},
                          ),
                        )
                      ],
                    ),
                  ),
                  bottom: 0,
                )
              ],
            )
                : LoadingWidget()));
  }



}
