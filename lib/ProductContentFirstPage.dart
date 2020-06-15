import 'package:flutter/material.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:transparent_image/transparent_image.dart';

import 'ApiManager.dart';
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
  List _attrList = [];
  String _selectedValue;
  ProductContentItem _productContent;

  @override
  void initState() {
    super.initState();
    this._productContent = this.widget.list[0];
    this._attrList = this.widget.list[0].attr;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    super.build(context);
    String pic = this._productContent.pic;
    pic = ApiManager.api + pic.replaceAll("\\", "/");
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
              "${this._productContent.title}",
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
                      Text("特价",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenAdapter.size(20))),
                      Text(
                        "${this._productContent.price}",
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
                      Text("原价",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenAdapter.size(20))),
                      Text(
                        "${this._productContent.oldPrice}",
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
                    onTap: () {},
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
