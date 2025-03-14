import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String keyEmail = "user_email";
  static const String keyPassword = "user_password";
  static const String keyName = "user_name";
  static const String keyRole = "user_role";

  /// Save user information.
  /// For Google Sign-In (if no name/role is available), you can pass empty strings.
  Future<void> saveUser({
    required String email,
    required String password,
    String name = "",
    String role = "",
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyPassword, password);
    await prefs.setString(keyName, name);
    await prefs.setString(keyRole, role);
  }

  /// Retrieve user information.
  Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(keyEmail);
    final password = prefs.getString(keyPassword);
    final name = prefs.getString(keyName);
    final role = prefs.getString(keyRole);
    if (email != null && password != null) {
      return {
        "email": email,
        "password": password,
        "name": name ?? "",
        "role": role ?? "",
      };
    }
    return null;
  }

  /// Check if a user is registered.
  Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(keyEmail) && prefs.containsKey(keyPassword);
  }

  /// Clear user information (for logout).
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyEmail);
    await prefs.remove(keyPassword);
    await prefs.remove(keyName);
    await prefs.remove(keyRole);
  }
}
