import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';

import 'model/ProductContentModel.dart';

class ProductContentTwoPage extends StatefulWidget {
  List<ProductContentItem> list;

  ProductContentTwoPage(this.list, {Key key}) : super(key: key);

  @override
  _ProductContentTwoPageState createState() => _ProductContentTwoPageState();
}

class _ProductContentTwoPageState extends State<ProductContentTwoPage> {
  var _id;

  @override
  void initState() {
    super.initState();
    this._id = widget.list[0].sId;
    print(this._id);
    //this._id=widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.setHeight(120)),
        child: Expanded(
            child: InAppWebView(
      initialUrl: "http://jd.itying.com/pcontent?id=${this._id}",
      onProgressChanged: (InAppWebViewController controller, int progress) {},
    )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
