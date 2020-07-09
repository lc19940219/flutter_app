import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/CartNum.dart';
import 'package:flutterapp/CartProvide.dart';
import 'package:flutterapp/CartService.dart';
import 'package:flutterapp/EventBus.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'ApiManager.dart';
import 'ProductCartNum.dart';
import 'model/ProductContentModel.dart';

class ProductContentFirstPage extends StatefulWidget {
  List<ProductContentItem> list;

  ProductContentFirstPage(this.list, {Key key}) : super(key: key);

  @override
  _ProductContentFirstPageState createState() =>
      _ProductContentFirstPageState();
}

class _ProductContentFirstPageState extends State<ProductContentFirstPage>
    with AutomaticKeepAliveClientMixin {
  List<Attr> _attrList = [];
  String _selectedValue;
  ProductContentItem _productContent;
  StreamSubscription productevent;
  CartProvide cartProvide;

  @override
  void initState() {
    super.initState();
    this._productContent = this.widget.list[0];
    this._attrList = this.widget.list[0].attr;
    _initAttr();
    this.productevent = eventBus.on<ProductContentEvent>().listen((event) {
      if (this._attrList.length > 0) {
        this._attrBottomSheet();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    this.productevent.cancel();
  }

  void _initAttr() {
    var arrtList = this._attrList;
    for (int i = 0; i < arrtList.length; i++) {
      for (int j = 0; j < arrtList[i].list.length; j++) {
        if (j == 0) {
          arrtList[i]
              .attrList
              .add({"title": arrtList[i].list[j], "check": true});
        } else {
          arrtList[i]
              .attrList
              .add({"title": arrtList[i].list[j], "check": false});
        }
      }
    }
    setState(() {
      this._attrList = arrtList;
    });
    getCheckValue();
  }

  void getCheckValue() {
    var arrt = this._attrList;
    List str = [];
    for (int i = 0; i < arrt.length; i++) {
      for (int j = 0; j < arrt[i].attrList.length; j++) {
        if (arrt[i].attrList[j]["check"] == true) {
          str.add(arrt[i].attrList[j]["title"]);
        }
      }
    }
    String value = str.join(",");
    setState(() {
      this._selectedValue = value;
      this._productContent.selectValue = this._selectedValue;
    });
  }

  List<Widget> _getAttrWidget(attrBottomSheetState) {
    List<Widget> list = [];

    this._attrList.forEach((value) {
      list.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.setWidth(120),
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "${value.cate}: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: ScreenAdapter.setWidth(600),
            child: Wrap(
              children: _getAttrItemWidget(value, attrBottomSheetState),
            ),
          )
        ],
      ));
    });
    return list;
  }

  List<Widget> _getAttrItemWidget(Attr value, attrBottomSheetState) {
//  List<Widget> list = [];

    return value.attrList.map((attrItems) {
      return Container(
        margin: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            _changeAttr(value.cate, attrItems['title'], attrBottomSheetState);
          },
          child: Chip(
            label: Text("${attrItems["title"]}"),
            backgroundColor: attrItems["check"] ? Colors.red : Colors.black26,
          ),
        ),
      );
    }).toList();
  }

  _changeAttr(cate, title, attrBottomSheetState) {
    var attrList = this._attrList;
    for (int i = 0; i < attrList.length; i++) {
      if (cate == attrList[i].cate) {
        for (int j = 0; j < attrList[i].attrList.length; j++) {
          attrList[i].attrList[j]["check"] = false;
          if (title == attrList[i].attrList[j]["title"]) {
            attrList[i].attrList[j]["check"] = true;
          }
        }
      }
    }
    attrBottomSheetState(() {
      this._attrList = attrList;
    });

    getCheckValue();
  }

  void _attrBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return StatefulBuilder(builder: (context, attrBottomSheetState) {
            return GestureDetector(
              onTap: () {
                return false;
              },
              behavior: HitTestBehavior.opaque,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(this.context).size.width,
                    height: ScreenAdapter.setHeight(700),
                    child: Stack(
                      children: <Widget>[
                        ListView(
                          children: <Widget>[
                            Column(
                              children: _getAttrWidget(attrBottomSheetState),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "数量: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child:
                                    ProductCartNum(this._productContent),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          child: Container(
                            height: ScreenAdapter.setHeight(100),
                            width: MediaQuery.of(this.context).size.width,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.black26, width: 1))),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: JDButton(
                                    color: Colors.yellow,
                                    str: "加入购物车",
                                    fun: () async {
                                      await CartService.add(
                                          this._productContent);
                                      print("${this._productContent.toJson()["count"]}///////////");

                                      this.cartProvide.updata();
                                      Fluttertoast.showToast(
                                          msg: "加入购物车成功",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          fontSize: 16.0);

                                      Navigator.pop(this.context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: JDButton(
                                    color: Colors.red,
                                    str: "立即购买",
                                    fun: () {
                                      Navigator.pop(this.context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          bottom: 0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    super.build(context);
    String pic = this._productContent.pic;
    pic = ApiManager.api + pic.replaceAll("\\", "/");
    this.cartProvide = Provider.of<CartProvide>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: pic,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.title}",
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdapter.size(28)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.subTitle}",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdapter.size(26)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Text("特价:",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenAdapter.size(28))),
                      Text(
                        " ￥${this._productContent.price}",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenAdapter.size(30)),
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价:",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenAdapter.size(28))),
                      Text(
                        " ￥${this._productContent.oldPrice}",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenAdapter.size(30),
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          this._attrList.length > 0
              ? Container(
                  height: ScreenAdapter.setHeight(80),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "已选: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenAdapter.size(28)),
                        ),
                        Text(
                          "${this._selectedValue}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.size(28)),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Divider(),
          Container(
            height: ScreenAdapter.setHeight(80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "运费: ",
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenAdapter.size(28)),
                ),
                Text(
                  "免运费",
                  style: TextStyle(
                      color: Colors.black54, fontSize: ScreenAdapter.size(28)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
