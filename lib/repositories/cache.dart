// ignore_for_file: constant_identifier_names

import 'package:honestorage/models/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheRepository {
  static const _STORAGE_KEY = "storage";
  static const _IDENTIFICATOR_KEY = "identificator";

  String? identificator = "", password;

  Future<String?> _getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key) ? prefs.getString(key) : null;
  }

  Future<String?> _setValue(String key, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      prefs.setString(key, value);
    } else {
      prefs.remove(key);
    }
    return value;
  }

  Future<void> flushCache(Storage storage) async {
    if (identificator != null) {
      // TOD: notify user.
      final serial = storage.serialize(password, identificator!);
      print("SERIAL: $serial");
      await _setValue(_STORAGE_KEY, serial);
    }
  }

  Future<String?> getCache() => _getValue(_STORAGE_KEY);
  Future<String?> setCache(String? storage) => _setValue(_STORAGE_KEY, storage);

  Future<String?> getId() => _getValue(_IDENTIFICATOR_KEY);
  Future<String?> setId(String? identificator) => _setValue(_IDENTIFICATOR_KEY, identificator);
}
