import 'package:flutter/material.dart';
import 'package:flutterapp/JdTextFiled.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:transparent_image/transparent_image.dart';

class AddressAddPage extends StatefulWidget {
  Map arguments;

  AddressAddPage({
    Key key,
    this.arguments,
  }) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.isEdit = widget.arguments['isEdit'];

    if (isEdit) {
      this.name = widget.arguments['name'];
      this.phone = widget.arguments['phone'];
      this.address = widget.arguments['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: !this.isEdit ? Text("增加") : Text("修改"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenAdapter.setWidth(20)),
        child: ListView(
          children: <Widget>[
            JdTextFiled(
              labeltext: "姓名",
              hinttext: "请输入姓名",
              onchange: (value) {
                // setState(() {
                this.name = value;
                // });
              },
              prefixicon: Icons.people,
              controller: TextEditingController.fromValue(TextEditingValue(
                text: this.name,
                selection: TextSelection.fromPosition(TextPosition(
                  offset: this.name.length,
                  affinity: TextAffinity.downstream,
                )),
              )),
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            JdTextFiled(
              labeltext: "手机号",
              hinttext: "请输入手机号",
              onchange: (value) {
                // setState(() {
                this.phone = value;
                // });
              },
              prefixicon: Icons.people,
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title:
                    this.area.length > 0 ? Text("${this.area}") : Text("省/市/区"),
                leading: Icon(Icons.local_activity),
              ),
            ),
            Divider(),
            JdTextFiled(
              labeltext: "详细地址",
              hinttext: "请输入详细地址",
              maxlines: 10,
              height: ScreenAdapter.setHeight(500),
              onchange: (value) {
                this.address = value;
              },
            ),
            SizedBox(
              height: ScreenAdapter.setHeight(100),
            ),
            FlatButton(
              onPressed: () {},
              child: this.isEdit ? Text("更新") : Text("新增"),
              color: Colors.red,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
