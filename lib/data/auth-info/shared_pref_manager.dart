import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const String _emailKey = "user_email";
  static const String _passwordKey = "user_password";

  /// Save user info (email and password)
  static Future<void> saveUserInfo(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  /// Retrieve user info from Shared Preferences
  static Future<Map<String, String>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "email": prefs.getString(_emailKey) ?? "",
      "password": prefs.getString(_passwordKey) ?? "",
    };
  }

  /// Check if user info exists
  static Future<bool> isUserRegistered() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_emailKey) && prefs.containsKey(_passwordKey);
  }

  /// Optionally clear user info (for logout or re-registration)
  static Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }
}
