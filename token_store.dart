import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get accessToken => _prefs.getString('access_token');

  static Future<void> save(String token) =>
      _prefs.setString('access_token', token);

  static Future<void> clear() => _prefs.remove('access_token');
}
