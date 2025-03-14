import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String keyEmail = "user_email";
  static const String keyPassword = "user_password";
  static const String keyName = "user_name";
  static const String keyRole = "user_role";

  Future<void> saveUser(String email, String password, String name, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyPassword, password);
    await prefs.setString(keyName, name);
    await prefs.setString(keyRole, role);
  }

  Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(keyEmail);
    final password = prefs.getString(keyPassword);
    final name = prefs.getString(keyName);
    final role = prefs.getString(keyRole);
    if (email != null && password != null && name != null && role != null) {
      return {
        "email": email,
        "password": password,
        "name": name,
        "role": role,
      };
    }
    return null;
  }
}
