import 'package:flutter/material.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/SearchService.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
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
            onChanged: (value) {},
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
              onTap: () {},
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
                          Fluttertoast.showToast(
                              msg: "${value}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER);
                        },
                        child: Chip(label: Text("${value}")),
                      );
                    }).toList(),
                  ),
                  _historyWidget(),
                ],
              ),
              flex: 1,
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            JDButton(
              color: Colors.red,
              str: "清除历史记录",
              fun: () {},
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
          ],
        ),
      ),
    );
  }

  _historyWidget() async {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            "历史记录",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Divider(),
        Wrap(
          runSpacing: ScreenAdapter.setWidth(20),
          spacing: ScreenAdapter.setWidth(20),
          alignment: WrapAlignment.spaceBetween,
          children: await SearchService.getHistoryList().map((value) {
            return Chip(label: Text("$value"));
          }).toList,
        )
      ],
    );
  }
}
