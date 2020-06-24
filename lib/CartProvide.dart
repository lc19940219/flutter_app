import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/service/Storage.dart';

class CartProvide with ChangeNotifier {
  List _cartList = []; //购物车数据
  CartProvide() {
    this.init();
  }

  List get cartList => this._cartList;

  void init() async {
    print("cartprovide init");

    try {
      List list = json.decode(await Storage.getString("cartlist"));
      this._cartList = list;
    } catch (e) {
      List list = [];
      this._cartList = list;
    }
    notifyListeners();
  }

  updata() {
    this.init();
  }

}
