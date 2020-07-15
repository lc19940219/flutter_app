import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignService {
  static getSign(Map json) {
    List list = json.keys.toList();
    list.sort();

    String sign = "";
    for (int i = 0; i < list.length; i++) {
      sign += "${list[i]}${json[list[i]]}";
    }
    print(sign);
    return md5.convert(utf8.encode(sign)).toString();
  }
}
