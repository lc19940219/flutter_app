import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<bool> setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(key);
  }

  static Future<bool> remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.remove(key);
  }

  static Future<bool> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.clear();
  }
}
