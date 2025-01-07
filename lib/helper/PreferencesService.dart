import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getCookie() {
    return _preferences.getString('cookie') ?? '';
  }

  static Future<void> setCookie(String cookie) async {
    await _preferences.setString('cookie', cookie);
  }
}
