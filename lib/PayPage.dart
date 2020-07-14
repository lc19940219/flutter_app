import 'package:flutter/material.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "chekced": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "chekced": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: this.payList.map((value) {
            return Container(
                child: Column(
              children: <Widget>[
                InkWell(
                  child: ListTile(
                    leading: Image.network(value["image"]),
                    title: Text("${value["title"]}"),
                    trailing: value["chekced"] ? Icon(Icons.check) : Text(""),
                  ),
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < this.payList.length; i++) {
                        payList[i]["chekced"] = false;
                      }
                      value["chekced"] = true;
                    });
                  },
                ),
                Divider()
              ],
            ));
          }).toList(),
        ),
      ),
    );
  }
}
