import 'package:shared_preferences/shared_preferences.dart';

class UserCashHelper {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';
  static const String _nameKey = 'name';
  static const String _phoneKey = 'phone';
  static const String _passwordKey = 'password';
  static const String _emailKey = 'email';
  static const String _profilePicKey = 'profilePic';

  // Save user data
  static Future<void> saveUser({
    required String name,
    required String phone,
    required String password,
    String? email,
    String? profilePicPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_nameKey, name);
    await prefs.setString(_phoneKey, phone);
    await prefs.setString(_passwordKey, password);
    if (email != null) {
      await prefs.setString(_emailKey, email);
    }
    if (profilePicPath != null) {
      await prefs.setString(_profilePicKey, profilePicPath);
    }
  }

  // Retrieve user data
  static Future<Map<String, String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey) ?? '',
      'phone': prefs.getString(_phoneKey) ?? '',
      'password': prefs.getString(_passwordKey) ?? '',
      'email': prefs.getString(_emailKey) ?? '',
      'profilePic': prefs.getString(_profilePicKey) ?? '',
    };
  }

  // Clear login status (logout)
  static Future<void> clearLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Save onboarding completion status
  static Future<void> setOnboardingSeen(bool seen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, seen);
  }

  // Retrieve onboarding completion status
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  // Check login status
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }
}
