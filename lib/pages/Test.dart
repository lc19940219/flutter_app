import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  showAboutDialogFun() {
    showAboutDialog(
        context: context,
        applicationName: "test",
        applicationVersion: "1.0.1",
        applicationIcon: Icon(
          Icons.ac_unit,
          size: 20,
        ),
        applicationLegalese: "1111111",
        children: <Widget>[
          Container(
            height: 30,
            color: Colors.blue,
          ),
          Container(
            height: 30,
            color: Colors.red,
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("组件"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("AboutDialog"),
            onTap: showAboutDialogFun,
          ),
          ListTile(
            title: Text("AnimatedAlign"),
            onTap: () {
              Navigator.pushNamed(context, "/AnimatedAlignPage");
            },
          )
        ],
      ),
    );
  }
}
