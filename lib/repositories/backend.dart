// ignore_for_file: constant_identifier_names

import 'package:honestorage/backends/backend.dart';
import 'package:honestorage/models/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:honestorage/repositories/download_none.dart'
    if (dart.library.io) 'package:honestorage/repositories/download_mobile.dart'
    if (dart.library.html) 'package:honestorage/repositories/download_web.dart';

class BackendRepository {
  static const _STORAGE_KEY = "storage";
  static const _IDENTIFICATOR_KEY = "identificator";

  FileHandle? backend;
  DateTime? updated;

  String? identificator = "", password;
  String? _lastCache;

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

  void setBackend(FileHandle handle) => backend = handle;

  Future<void> flushCache(Storage storage) async {
    if (identificator != null) {
      // TODO: if identifier == null: notify user.
      _lastCache = storage.serialize(password, identificator!);
      await _setValue(_STORAGE_KEY, _lastCache);
      await backend?.populate(_lastCache);
      updated = DateTime.now();
    }
  }

  void save(String name) => savePlatform(_lastCache!.codeUnits, name);

  Future<String?> getCache() => _getValue(_STORAGE_KEY);
  Future<String?> setCache(String? storage) => _setValue(_STORAGE_KEY, storage);

  Future<String?> getId() => _getValue(_IDENTIFICATOR_KEY);
  Future<String?> setId(String? identificator) => _setValue(_IDENTIFICATOR_KEY, identificator);
}
