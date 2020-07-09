import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/service/Storage.dart';

class  CartProvide with ChangeNotifier {
  List _cartList = []; //购物车数据
  bool _isCheckedAll = false; //全选
  double _allPrice = 0; //总价

  CartProvide() {
    this.init();
  }

  List get cartList => this._cartList;

  bool get isCheckedAll => this._isCheckedAll;

  double get allPrice => this._allPrice;

  void init() async {
    print("cartprovide init");

    try {
      List list = json.decode(await Storage.getString("cartlist"));
      this._cartList = list;
    } catch (e) {
      List list = [];
      this._cartList = list;
    }
    this._isCheckedAll=this.isCheckAll();
    this.computeAllPrice();
    notifyListeners();
  }

  updata() {
    this.init();
  }

  itemCountChange() {
    Storage.setString("cartlist", json.encode(this._cartList));
    this.computeAllPrice();
    notifyListeners();
  }

  checkAllItem(bool value) {
    for (int i = 0; i < this._cartList.length; i++) {
      this._cartList[i]["checked"] = value;
    }
    this._isCheckedAll = value;
    this.computeAllPrice();
    Storage.setString("cartlist", json.encode(this._cartList));
    notifyListeners();
  }

  bool isCheckAll() {
    if (this._cartList.length > 0) {
      for (int i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]["checked"] == false) {
          return false;
        }

      }
      return true;
    }
    return false;

  }

  itemChange() {
    if (this.isCheckAll()) {
      this._isCheckedAll = true;
    } else {
      this._isCheckedAll = false;
    }
    this.computeAllPrice();
    print(this._isCheckedAll);
    Storage.setString("cartlist", json.encode(this._cartList));
    notifyListeners();
  }

  computeAllPrice() {
    double sum = 0;
    for (int i = 0; i < this._cartList.length; i++) {
      if (this.cartList[i]["checked"]) {
        sum += this._cartList[i]["price"] * this._cartList[i]["count"];
      }
    }
    this._allPrice = sum;
    notifyListeners();
  }

  removeItem() {
    List temp = [];
    for (int i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"]==false) {
        temp.add(this._cartList[i]);
      }
    }
    this._cartList = temp;
    this.computeAllPrice();
    Storage.setString("cartlist", json.encode(this._cartList));
    notifyListeners();
  }
}
