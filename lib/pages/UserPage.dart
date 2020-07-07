import 'package:flutter/material.dart';
import 'package:flutterapp/EventBus.dart';
import 'package:flutterapp/JDButton.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/UserServices.dart';
import 'package:transparent_image/transparent_image.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLogin = false;
  List userInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBus.on<UserEvent>().listen((event) {
      this._getUserinfo();
    });
    this._getUserinfo();
  }

  void _getUserinfo() async {
    var isLogin = await UserServices.getUserLoginState();
    var userInfo = await UserServices.getUserInfo();
    setState(() {
      this.userInfo = userInfo;
      this.isLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdapter.setHeight(200),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/user_bg.jpg"),
                    fit: BoxFit.cover)),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: "images/user.png",
                      image: "",
                      fit: BoxFit.cover,
                      width: ScreenAdapter.setWidth(110),
                      height: ScreenAdapter.setWidth(110),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenAdapter.setWidth(20),
                ),
                !this.isLogin
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/Login");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("登录注册", style: TextStyle(color: Colors.white))
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${this.userInfo[0]['username']}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: ScreenAdapter.setHeight(20),
                            ),
                            Text(
                              "普通会员",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text("全部订单"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text("待付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text("待收货"),
          ),
          Container(
              width: double.infinity,
              height: 10,
              color: Color.fromRGBO(242, 242, 242, 0.9)),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text("我的收藏"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text("在线客服"),
          ),
          Divider(),
          this.isLogin
              ? Container(
                  padding: EdgeInsets.all(20),
                  child: JDButton(
                    color: Colors.red,
                    str: "退出登录",
                    fun: () {},
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
