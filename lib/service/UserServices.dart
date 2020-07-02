import 'dart:convert';
import 'dart:html';

import 'package:flutterapp/service/Storage.dart';

class UserServices {
  static getUserInfo() async {
    List userInfo;
    try {
      userInfo = json.decode(await Storage.getString("userInfo"));
    } catch (e) {
      userInfo = [];
    }
    return userInfo;
  }

  static getUserLoginState() async {
    List userInfo = await getUserInfo();
    if (userInfo.length > 0 && userInfo[0]["username"] != "") {
      return true;
    } else {
      return false;
    }
  }

  static loginOut() async{
   await Storage.remove("userInfo");
  }
}
