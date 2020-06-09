import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/LoadingWidget.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:transparent_image/transparent_image.dart';

import 'model/ProductModel.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  var _textEditextcController = TextEditingController();
  int _page = 1;
  var _sort = "";
  int _pageSize = 8;
  List<ProductItem> _productList = [];
  var hasData = false;
  var hasMore = true;
  ScrollController _scrollController;
  List testList = ["333", "555", "666"];
  var _keywords;
  List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  var _selectHeaderId = 1;
  var flag = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var api;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.hasMore && this.flag) {
          _getProductListData();
          print(this._page);
        }
      }
    });
    _getProductListData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.setHeight(70),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenAdapter.setWidth(35))),
              color: Color.fromRGBO(233, 233, 233, 0.8)),
          child: TextField(
            controller: this._textEditextcController,
            onChanged: (str) {},
            autofocus: true,
            decoration: InputDecoration(
                hintText: "请输入",
                contentPadding: EdgeInsets.fromLTRB(ScreenAdapter.setWidth(30),
                    ScreenAdapter.setWidth(30), 0, 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenAdapter.setWidth(35)),
                    ),
                    borderSide: BorderSide.none),
                suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      this._textEditextcController.text = "";
                      this._keywords = "";
                      this._selectHeaderId = 1;
                    })),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              height: ScreenAdapter.setHeight(70),
              padding: EdgeInsets.only(right: ScreenAdapter.setWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "搜索",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: ScreenAdapter.size(28)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: Text("筛选"),
      ),
      body: this.hasData
          ? Stack(
              children: <Widget>[
                _productListWidget(),
                _subHeaderWidget(),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  _subHeaderWidget() {
    return Positioned(
      child: Container(
        height: ScreenAdapter.setHeight(80),
        width: double.infinity,
        child: Row(
          children: this._subHeaderList.map((value) {
            return Expanded(
              child: InkWell(
                  onTap: () {
                    _subHeaderChange(value["id"]);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenAdapter.setWidth(10),
                        top: 0,
                        right: ScreenAdapter.setWidth(10),
                        bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${value['title']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: this._selectHeaderId == value["id"]
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        _showIcon(value["id"])
                      ],
                    ),
                  )),
              flex: 1,
            );
          }).toList(),
        ),
      ),
      top: 0,
      height: ScreenAdapter.setHeight(80),
      width: ScreenAdapter.getScreenWidth(),
    );
  }

  _productListWidget() {
    return this._productList.length > 0
        ? Container(
            margin: EdgeInsets.only(top: ScreenAdapter.setHeight(80)),
            padding: EdgeInsets.all(ScreenAdapter.setWidth(10)),
            color: Colors.white,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                String pic = this._productList[index].pic;
                pic = ApiManager.api + pic.replaceAll("\\", "/");
                return Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.setWidth(180),
                            height: ScreenAdapter.setHeight(180),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenAdapter.setWidth(5))),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: pic,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: ScreenAdapter.setHeight(180),
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${this._productList[index].title}",
                                  maxLines: 2,
                                ),
                                Wrap(
                                  runSpacing: ScreenAdapter.setWidth(10),
                                  spacing: ScreenAdapter.setWidth(10),
                                  children: this.testList.map((value) {
                                    return Container(
                                      height: ScreenAdapter.setHeight(36),
                                      margin: EdgeInsets.only(right: 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromRGBO(230, 230, 230, 0.9),
                                      ),
                                      child: Text("${value}"),
                                    );
                                  }).toList(),
                                ),
                                Text(
                                  "￥${this._productList[index].price}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                      Divider(),
                      _showLoading(index)
                    ],
                  ),
                );
              },
              itemCount: this._productList.length,
              controller: _scrollController,
            ),
          )
        : LoadingWidget();
  }

  void _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    if (this._keywords == null) {
      api =
          '${ApiManager.api}api/plist?cid=${widget.arguments["id"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    } else {
      api =
          '${ApiManager.api}api/plist?search=${this._keywords}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    }
    var response = await Dio().get(api);

    var list = ProductModel.fromJson(response.data);

    if (list.result.length == 0 && this._page == 1) {
      setState(() {
        this.hasData = false;
      });
    } else {
      setState(() {
        this.hasData = true;
      });
    }

    if (list.result.length < this._pageSize) {
      setState(() {
        this.hasMore = false;
        this._productList.addAll(list.result);
        this.flag = true;
      });
    } else {
      setState(() {
        this._productList.addAll(list.result);
        this._page++;
        this.flag = true;
      });
    }
  }

  _showLoading(int index) {
    if (this.hasMore) {
      return index == this._productList.length - 1 ? LoadingWidget() : Text("");
    } else {
      return index == this._productList.length - 1 ? Text("我是有底线的") : Text("");
    }
  }

  void _subHeaderChange(index) {
    if (index == 4) {
      this._scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectHeaderId = index;
      });
    } else {
      setState(() {
        this._selectHeaderId = index;
        this._sort =
            "${this._subHeaderList[index - 1]['fileds']}_${this._subHeaderList[index - 1]['sort']}";
        this._page = 1;
        this._productList = [];
        this.hasMore = true;
        this._subHeaderList[index - 1]['sort'] =
            this._subHeaderList[index - 1]['sort'] * -1;
        try {
          _scrollController.jumpTo(0);
        } catch (e) {}
      });
    }
    this._getProductListData();
  }

  _showIcon(value) {
    if (value == 2 || value == 3) {
      if (this._subHeaderList[value - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_up);
      } else {
        return Icon(Icons.arrow_drop_down);
      }
    } else {
      return Text("");
    }
  }
}
