import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLoginStat(bool stat) async {
  final pref = await SharedPreferences.getInstance();

  return pref.setBool('isLoggedIn', stat);
}

Future<bool> getLoginStat() async {
  final pref = await SharedPreferences.getInstance();

  return pref.getBool('isLoggedIn') ?? false;
}

Future<bool> setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.setString('authToken', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('authToken');
}
