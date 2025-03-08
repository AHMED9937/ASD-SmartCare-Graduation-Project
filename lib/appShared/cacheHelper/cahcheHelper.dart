import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

static dynamic getData({required String key}){
  return _preferences?.get(key);
}

  static Future<bool?> SaveData({required String key, required dynamic value}) async {
  
  if (value is String) return _preferences?.setString(key, value);
  if (value is bool) return _preferences?.setBool(key, value);
  if (value is int) return _preferences?.setInt(key, value);
  if (value is double) return _preferences?.setDouble(key, value);
  return null;

}


  /// Save a string value
  
}
