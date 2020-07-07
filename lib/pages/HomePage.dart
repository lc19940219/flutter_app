import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/model/Focus.dart';
import 'package:flutterapp/model/ProductModel.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:transparent_image/transparent_image.dart';

import '../ApiManager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusdata = [];
  List<ProductItem> _isHotdata = [];
  List<ProductItem> _isBestdata = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/SearchPage");
          },
          child: Container(
            padding: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
            height: ScreenAdapter.setHeight(70),
            child: Row(
              children: <Widget>[Text("笔记本")],
            ),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenAdapter.setWidth(70))),
              color: Color.fromARGB(233, 233, 233, 233),
            ),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.message,
              size: ScreenAdapter.setWidth(56),
            ),
            onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.message), onPressed: () {})
        ],
      ),
      body: ListView(
        children: <Widget>[
          _swiperWidget(),
          SizedBox(
            height: ScreenAdapter.setHeight(10),
          ),
          _titleWidget("猜你喜欢"),
          SizedBox(
            height: ScreenAdapter.setHeight(10),
          ),
          _hotProductListWidget(),
          SizedBox(
            height: ScreenAdapter.setHeight(10),
          ),
          _titleWidget("热门推荐"),
          SizedBox(
            height: ScreenAdapter.setHeight(10),
          ),
          _recProductItemWidget(),
        ],
      ),
    );
  }

  Widget _swiperWidget() {
    return this._focusdata.length > 0
        ? AspectRatio(
            aspectRatio: 2,
            child: Swiper(
              itemCount: this._focusdata.length,
              itemBuilder: (BuildContext context, int index) {
                String pic = this._focusdata[index].pic;
                pic = ApiManager.api + pic.replaceAll("\\", "/");
                return Image.network(
                  "${pic}",
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              pagination: SwiperPagination(),
            ),
          )
        : Text("加载中");
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.setHeight(33),
      padding: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
      margin: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenAdapter.setWidth(5)))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  Widget _hotProductListWidget() {
    return this._isHotdata.length > 0
        ? Container(
            height: ScreenAdapter.setHeight(235),
            child: ListView.builder(
              padding: EdgeInsets.all(ScreenAdapter.setWidth(20)),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String pic = this._isHotdata[index].pic;
                pic = ApiManager.api + pic.replaceAll("\\", "/");
                return InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.setWidth(140),
                        height: ScreenAdapter.setHeight(140),
                        padding:
                            EdgeInsets.only(left: ScreenAdapter.setWidth(10)),
                        child: Image.network(
                          "${pic}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(top: ScreenAdapter.setHeight(10)),
                        height: ScreenAdapter.setHeight(44),
                        child: Text(
                          "￥${this._isHotdata[index].price}",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: this._isHotdata.length,
            ),
          )
        : Text("加载中");
  }

  Widget _recProductItemWidget() {
    double width =
        (ScreenAdapter.getScreenWidth() - ScreenAdapter.setWidth(50)) / 2;
    return this._isBestdata.length > 0
        ? Container(
            padding: EdgeInsets.only(
                left: ScreenAdapter.setWidth(10),
                right: ScreenAdapter.setWidth(10),
                bottom: ScreenAdapter.setHeight(10)),
            child: Wrap(
              runSpacing: ScreenAdapter.setWidth(10),
              spacing: ScreenAdapter.setWidth(10),
              children: this._isBestdata.map((value) {
                String pic = value.pic;
                pic = ApiManager.api + pic.replaceAll("\\", "/");
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: width,
                    // padding: EdgeInsets.all(ScreenAdapter.setWidth(10)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: ScreenAdapter.setWidth(2),
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage, image: pic),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenAdapter.setHeight(5)),
                          child: Text(
                            "${value.title}",
                            maxLines: 2,
                            style: TextStyle(color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenAdapter.setHeight(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("${value.price}"),
                              Text("${value.oldPrice}")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        : Text("加载中");
  }

  _getFocusData() async {
    var api = "${ApiManager.api}api/focus";
    var result = await Dio().get(api);
    var foucsList = FocusModel.fromJson(result.data);
    setState(() {
      this._focusdata = foucsList.result;
    });
  }

  _getHotProductData() async {
    var api = "${ApiManager.api}api/plist?is_hot=1";
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    print(hotProductList);
    setState(() {
      this._isHotdata = hotProductList.result;
    });
  }

  _getBestProductData() async {
    var api = "${ApiManager.api}api/plist?is_best=1";
    var result = await Dio().get(api);
    var bestList = ProductModel.fromJson(result.data);
    setState(() {
      this._isBestdata = bestList.result;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
