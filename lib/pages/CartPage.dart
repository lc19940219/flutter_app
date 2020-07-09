import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutterapp/CartItem.dart';
import 'package:flutterapp/CartService.dart';
import 'package:flutterapp/model/ProductContentModel.dart';
import 'package:flutterapp/pages/CheckOutProvide.dart';
import 'package:flutterapp/service/ScreenAdapter.dart';
import 'package:flutterapp/service/UserServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../CartProvide.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartProvide cartProvider;
  bool _isEdit = false;
  CheckOutProvide checkOutProvide;
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvide>(context);
    checkOutProvide = Provider.of<CheckOutProvide>(context);
    print(cartProvider.cartList);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        centerTitle: true,
        actions: <Widget>[
          this.cartProvider.cartList.length > 0
              ? InkWell(
                  onTap: () {
                    setState(() {
                      this._isEdit = !this._isEdit;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !this._isEdit ? Text("编辑") : Text("完成")
                      ],
                    ),
                  ),
                )
              : Text("")
        ],
      ),
      body: cartProvider.cartList.length > 0
          ? Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenAdapter.setHeight(125)),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      print(cartProvider.cartList[index]);
                      return CartItem(cartProvider.cartList[index]);
                    },
                    itemCount: cartProvider.cartList.length,
                  ),
                ),
                Positioned(
                  child: Container(
                    height: ScreenAdapter.setHeight(120),
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (value) {
                                  cartProvider.checkAllItem(value);
                                },
                                activeColor: Colors.red,
                                value: cartProvider.isCheckedAll,
                              ),
                              this._isEdit
                                  ? Text("")
                                  : Text("合计",
                                      style: TextStyle(color: Colors.red)),
                              this._isEdit
                                  ? Text("")
                                  : Text("${cartProvider.allPrice}",
                                      style: TextStyle(color: Colors.red))
                            ],
                          ),
                        ),
                        this._isEdit
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: RaisedButton(
                                  child: Text("删除"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    cartProvider.removeItem();
                                  },
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerRight,
                                child: RaisedButton(
                                  child: Text("结算"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  color: Colors.red,
                                  onPressed: checkout,
                                  textColor: Colors.white,
                                ))
                      ],
                    ),
                  ),
                  bottom: 0,
                )
              ],
            )
          : Container(
              child: Center(
                child: Text("购物车空空的"),
              ),
            ),
    );
  }

  void checkout() async {
    List list = await CartService.getSelectData();
    if (list.length > 0) {
      bool isLogin = await UserServices.getUserLoginState();
      if (isLogin) {
        checkOutProvide.changecheckoutList(list);

        Navigator.pushNamed(context, "/CheckOutPage");
      } else {
        Fluttertoast.showToast(
            msg: "请先登录",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
        Navigator.pushNamed(context, "/Login");
      }
    } else {
      Fluttertoast.showToast(
          msg: "请先选择结算商品",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }
}
