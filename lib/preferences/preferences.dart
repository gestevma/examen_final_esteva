import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _user = '';
  static String _password = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get user {
    return _prefs.getString('user') ?? _user;
  }

  static set user(String user) {
    _user = user;
    _prefs.setString('user', user);
  }

  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set password(String password) {
    _password = password;
    _prefs.setString('password', password);
  }
}
