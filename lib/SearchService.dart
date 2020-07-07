import 'dart:convert';

import 'package:flutterapp/service/Storage.dart';

class SearchService {
  static setHistoryData(keyData) async {
    try {
      List searchList = json.decode(await Storage.getString("searchList"));
      var hasData = searchList.any((value) => value == keyData);

      if (!hasData) {
        searchList.add(keyData);
        await Storage.setString("searchList", json.encode(searchList));
      }
    } catch (e) {
      List list = [];
      list.add(keyData);
      await Storage.setString("searchList", json.encode(list));
    }
  }

  static   getHistoryList() async {
    try {
      List searchList = json.decode(await Storage.getString("searchList"));
      return searchList;
    } catch (e) {
      return [];
    }
  }

  static hasHiatoryData() async {
    try {
      List searchList = json.decode(await Storage.getString("searchList"));
      if (searchList.length > 0) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static removeHistoryData(keyData) async {
    List searchListData = json.decode(await Storage.getString('searchList'));
    searchListData.remove(keyData);
    await Storage.setString("searchList", json.encode(searchListData));
  }

  static clear() async {
    await Storage.remove("searchList");
  }
}
