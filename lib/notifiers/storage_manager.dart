

import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {


  static void saveTheme(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("key", key);
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("key");
  }

}