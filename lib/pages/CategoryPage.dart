import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/model/CateModel.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List _catedata = [];
  int _selectIndex = 0;
  List<CateItem> _rightCateList = [];

  Widget _leftView(leftWidth) {
    return Container(
      width: leftWidth,
      height: double.infinity,
      child: this._catedata.length > 0
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      _getRightData(this._catedata[index].sId);
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: ScreenAdapter.setHeight(84),
                        padding:
                            EdgeInsets.only(top: ScreenAdapter.setHeight(24)),
                        color: this._selectIndex == index
                            ? Color.fromRGBO(240, 246, 246, 0.9)
                            : Colors.white,
                        child: Text(
                          "${this._catedata[index].title}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  ),
                );
              },
              itemCount: this._catedata.length,
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                ],
              ),
            ),
    );
  }

  Widget _rightView(rightWidth, rightHeigh) {
    return Expanded(
        child: this._rightCateList.length > 0
            ? Container(
                height: double.infinity,
                color: Color.fromRGBO(240, 246, 246, 0.9),
                padding: EdgeInsets.all(ScreenAdapter.setWidth(20)),
                child: GridView.builder(
                    itemCount: this._rightCateList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: ScreenAdapter.setWidth(10),
                      childAspectRatio: rightWidth / rightHeigh,
                      crossAxisSpacing: ScreenAdapter.setWidth(10),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      String pic = this._rightCateList[index].pic;
                      pic = ApiManager.api + pic.replaceAll("\\", "/");
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/ProductListPage",arguments: {"id":this._rightCateList[index].sId});
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage, image: pic),
                              ),
                            ),
                            Container(
                              height: ScreenAdapter.setHeight(60),
//                              padding: EdgeInsets.only(
//                                  top: ScreenAdapter.setHeight(5)),
                              child: Center(
                                child: Text(
                                  "${this._rightCateList[index].title}",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                  ],
                ),
              ));
  }

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  void _getLeftCateData() async {
    var api = "${ApiManager.api}api/pcate";

    var result = await Dio().get(api);

    var catelist = CateModel.fromJson(result.data);

    setState(() {
      this._catedata = catelist.result;
      if (catelist.result.length > 0) {
        _getRightData(catelist.result[0].sId);
      }
    });
  }

  _getRightData(pid) async {
    var api = "${ApiManager.api}api/pcate?pid=${pid}";
    var result = await Dio().get(api);
    var catelist = CateModel.fromJson(result.data);
    print(catelist);
    setState(() {
      this._rightCateList = catelist.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenAdapter.init(context);

    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    var rightWidth = (ScreenAdapter.getScreenWidth() -
            leftWidth -
            ScreenAdapter.setWidth(50)) /
        3;
    var rightHeigh = ScreenAdapter.setHeight(70) + rightWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Row(
        children: <Widget>[
          _leftView(leftWidth),
          _rightView(rightWidth, rightHeigh),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
