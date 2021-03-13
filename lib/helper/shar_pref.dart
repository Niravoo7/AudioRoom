import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static SharedPreferences prefs;

  static const String keyMobileNo = "USER_MOBILE_NUMBER";
  static const String keyUId = "USER_UNIQUE_ID";

  //int
  static Future prefSetInt(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<int> prefGetInt(String key, int intDef) async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getInt(key) != null) {
      return prefs.getInt(key);
    } else {
      return intDef;
    }
  }

  //bool
  static Future prefSetBool(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> prefGetBool(String key, bool boolDef) async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key) != null) {
      return prefs.getBool(key);
    } else {
      return boolDef;
    }
  }

  //String
  static Future prefSetString(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> prefGetString(String key, String strDef) async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getString(key);
    } else {
      return strDef;
    }
  }

  //Double
  static Future prefSetDouble(String key, double value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<double> prefGetDouble(String key, double douDef) async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble(key) != null) {
      return prefs.getDouble(key);
    } else {
      return douDef;
    }
  }

  static Future clearAllPref() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future clearPref(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
