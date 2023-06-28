import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  void ConfirmUserAction(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> GetConfirmation(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
