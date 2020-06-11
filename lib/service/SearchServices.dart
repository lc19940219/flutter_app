import 'dart:convert';

import 'package:flutterapp/service/Storage.dart';

class SearchServices {
  static setHistoryData(keyWord) async {
    try {
      List searchList = json.decode(await Storage.getString("searchList"));
      bool hasData = searchList.any((value) => keyWord == value);
      if (!hasData) {
        searchList.add(keyWord);
        await Storage.setString("searchList", json.encode(searchList));
      }
    } catch (e) {
      List list = [];
      list.add(keyWord);
      await Storage.setString("searchList", json.encode(list));
    }
  }

  static getHistoryData() async {
    try {
      List searchList = json.decode(await Storage.getString("searchList"));
      return searchList;
    } catch (e) {
      return [];
    }
  }

  static removeHistoryData(keyWord) async {
    List searchList = json.decode(await Storage.getString("searchList"));
    searchList.remove(keyWord);
    await Storage.setString("searchList", json.encode(searchList));
  }

  static clear() async {
    await Storage.remove("searchList");
  }
}
