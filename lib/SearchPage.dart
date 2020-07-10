import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/SearchService.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/SearchServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List hot = [
    "笔记本",
    "手机",
    "电话",
    "食品",
    "饮料",
    "电视",
    "笔记本111",
    "1111",
    "电话1111",
    "食品1111",
    "饮料1111",
    "电视1111"
  ];
  List _historyData = [];
  var _keyword;
  bool _hasHistory = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getHistortData();
  }

  _getHistortData() async {
    List list = await SearchService.getHistoryList();
    bool b = await SearchService.hasHiatoryData();
    setState(() {
      this._hasHistory = b;
      this._historyData = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.setHeight(70),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenAdapter.setWidth(35))),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                this._keyword = value;
              });
            },
            cursorColor: Colors.transparent,
            cursorRadius: Radius.circular(0),
            cursorWidth: 0,
            enableInteractiveSelection:false,
            autofocus: true,
            decoration: InputDecoration(
                hintText: "请输入",
                contentPadding: EdgeInsets.only(
                    left: ScreenAdapter.setWidth(30),
                    top: ScreenAdapter.setWidth(10),
                    bottom: 0,
                    right: 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenAdapter.setWidth(35))),
                    borderSide: BorderSide.none)),
          ),
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                SearchService.setHistoryData(this._keyword);
                Navigator.pushReplacementNamed(context, "/ProductListPage",
                    arguments: {"keyword": this._keyword});
                // this._getHistortData();
              },
              child: Container(
                padding: EdgeInsets.all(ScreenAdapter.setWidth(20)),
                child: Center(
                  child: Text("搜索"),
                ),
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.setWidth(10)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Text(
                      "热门搜索",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Divider(),
                  Wrap(
                    runSpacing: ScreenAdapter.setWidth(20),
                    spacing: ScreenAdapter.setWidth(20),
                    alignment: WrapAlignment.spaceBetween,
                    children: this.hot.map((value) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/ProductListPage",
                              arguments: {"keyword": value});
                        },
                        child: Chip(label: Text("${value}")),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: ScreenAdapter.setHeight(20),
                  ),
                  _historyWidget(),
                ],
              ),
              flex: 1,
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            this._hasHistory
                ? JDButton(
                    color: Colors.red,
                    str: "清除历史记录",
                    fun: () async {
                      await SearchService.clear();
                      this._getHistortData();
                    },
                  )
                : Text(""),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
          ],
        ),
      ),
    );
  }

  _historyWidget() {
    return this._hasHistory
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "历史记录",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Divider(),
                Wrap(
                  runSpacing: ScreenAdapter.setWidth(20),
                  spacing: ScreenAdapter.setWidth(20),
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: this._historyData.map((e) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/ProductListPage",
                            arguments: {"keyword": e});
                      },
                      onLongPress: () async {
                        _showDeleteDialog(e);
                      },
                      child: Chip(
                        label: Text("$e"),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        : Text("");
  }

  void _showDeleteDialog(e) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息"),
            content: Text("您确定要删除吗"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  await SearchServices.removeHistoryData(e);
                  this._getHistortData();
                  Navigator.pop(context, 'ok');
                },
              ),
            ],
          );
        });

    await SearchService.removeHistoryData(e);
    this._getHistortData();
  }
}
