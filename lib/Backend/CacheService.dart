import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/OldBackend/OldFirebaseService.dart';

class CacheService {
  void ConfirmuserAction(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> ProoveUserAuthentication(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
