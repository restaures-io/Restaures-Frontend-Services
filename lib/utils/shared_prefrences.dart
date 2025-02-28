import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Set String
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get String
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // Set Int
  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // Get Int
  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Set Bool
  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Get Bool
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Remove Key
  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear All Data
  static Future<void> clear() async {
    await _prefs.clear();
  }

  // Check if Key Exists
  static bool contains(String key) {
    return _prefs.containsKey(key);
  }
}
