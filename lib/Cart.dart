import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  num _count = 0;

  num get count => this._count;

  void increment() {
    this._count++;
    notifyListeners();
  }
}
