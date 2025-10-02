import 'package:shared_preferences/shared_preferences.dart';

class SharedUtils {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await sharedPreferences?.setString(key, value);
  }

  static setBoolean(String key, bool value) async {
    sharedPreferences?.setBool(key, value);
  }

  static setInt(String key, int value) async {
    sharedPreferences?.setInt(key, value);
  }

  static Future<String> getString(String key) async {
    return (sharedPreferences?.getString(key) ?? "");
  }

  static Future<bool> getBoolean(String key) async {
    return (sharedPreferences?.getBool(key) ?? false);
  }

  static Future<int> getInt(String key) async {
    return (sharedPreferences?.getInt(key) ?? 0);
  }

  static removeString(String key) async {
    return (sharedPreferences?.remove(key));
  }
}