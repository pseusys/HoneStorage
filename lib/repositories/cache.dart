// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class CacheRepository {
  static const _STORAGE_KEY = "storage";

  Future<String?> getCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_STORAGE_KEY);
  }

  Future<String?> setCache(String? storage) async {
    final prefs = await SharedPreferences.getInstance();
    if (storage != null) {
      prefs.setString(_STORAGE_KEY, storage);
    } else {
      prefs.remove(_STORAGE_KEY);
    }
    return storage;
  }
}
