import 'package:flutter/material.dart';

class CheckOutProvide with ChangeNotifier {
  List _checkoutList = [];
  double _allPrice = 0;

  List get checkoutList => this._checkoutList;

  double get allPrice => this._allPrice;

  changecheckoutList(data) {
    this._checkoutList = data;

    getAllPrice();
    notifyListeners();
  }

  void getAllPrice() {
    double sum = 0;
    for (int i = 0; i < this.checkoutList.length; i++) {
      sum += this._checkoutList[i]["price"] * this._checkoutList[i]["count"];
    }
    this._allPrice = sum;
    notifyListeners();
  }
}
