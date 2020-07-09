import 'dart:convert';

import 'package:flutterapp/ApiManager.dart';
import 'package:flutterapp/model/ProductContentModel.dart';
import 'package:flutterapp/service/Storage.dart';

class CartService {
  static add(item) async {
    item = formatCartData(item);
    try {
      List list = json.decode(await Storage.getString("cartlist"));

      var hasData = list.any((value) {
        return item["_id"] == value["_id"] &&
            item["selectValue"] == value["selectValue"];
      });
      if (hasData) {
        for (int i = 0; i < list.length; i++) {
          if (item["_id"] == list[i]["_id"] &&
              item["selectValue"] == list[i]["selectValue"]) {
            list[i]["count"] += item["count"];

            await Storage.setString("cartlist", json.encode(list));
            return;
          }
        }
      } else {
        list.add(item);
        await Storage.setString("cartlist", json.encode(list));
      }
    } catch (e) {
      List list = [];
      list.add(item);
      await Storage.setString("cartlist", json.encode(list));
    }
  }

  static formatCartData(ProductContentItem item) {
    String url = item.pic;
    url = ApiManager.api + url.replaceAll("\\", "/");
    Map<String, dynamic> data = new Map();
    data['_id'] = item.sId;
    data['title'] = item.title;
    if (item.price is int || item.price is double) {
      data["price"] = item.price;
    } else {
      data["price"] = double.parse(item.price);
    }
    data['pic'] = url;
    data['selectValue'] = item.selectValue;
    data['count'] = item.count;
    data['checked'] = true;
    return data;
  }

  static getSelectData() async {
    List cartList = [];
    List tempList = [];
    try {
      cartList = json.decode(await Storage.getString("cartlist"));
    } catch (e) {
      cartList = [];
    }
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i]['checked'] == true) {
        tempList.add(cartList[i]);
      }
    }
    return tempList;
  }
}
