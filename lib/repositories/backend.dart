// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:honestorage/backends/backend.dart';
import 'package:honestorage/blocs/status/status.dart';
import 'package:honestorage/models/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:honestorage/repositories/download_none.dart'
    if (dart.library.io) 'package:honestorage/repositories/download_mobile.dart'
    if (dart.library.html) 'package:honestorage/repositories/download_web.dart';

class BackendRepository {
  static const _STORAGE_KEY = "storage";
  static const _IDENTIFICATOR_KEY = "identificator";

  final _status = StreamController<BackendStatus>.broadcast();
  Stream<BackendStatus> get statusStream => _status.stream;
  late BackendStatus latestStatus;

  String? identificator = "", password;
  FileHandle? backend;

  Future<String?> _getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key) ? prefs.getString(key) : null;
  }

  BackendRepository() {
    _status.stream.listen((event) => latestStatus = event);
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
    if (identificator == null) {
      // TODO: if identifier == null: notify user and switch to init page.
    }
    if (backend == null || !backend!.syncAvailable) return;

    final serial = storage.serialize(password, identificator!);
    await _setValue(_STORAGE_KEY, serial);
    if (backend!.syncEnabled) await backend!.populate(serial);
    _status.sink.add(BackendStatus(DateTime.now(), serial, true, backend!.syncEnabled));
  }

  Future<String> setBackend(FileHandle? handle) async {
    backend = handle;
    final cache = await setCache(handle?.contents ?? Storage.create().serialize(null, identificator!));
    _status.sink.add(BackendStatus(DateTime.now(), cache!, backend?.syncAvailable ?? false, backend?.syncEnabled ?? false));
    return cache;
  }

  void setStatus(String ch) => _status.sink.add(BackendStatus(DateTime.now(), ch, backend?.syncAvailable ?? false, backend?.syncEnabled ?? false));

  void save(String cache, String name) => savePlatform(cache.codeUnits, name);

  Future<void> enableSync(bool enable) async {
    if (backend != null && backend!.syncAvailable) {
      backend!.syncEnabled = enable;
      final cache = await getCache();
      if (enable) await backend!.populate(cache);
      _status.sink.add(BackendStatus(DateTime.now(), cache!, true, enable));
    }
  }

  Future<String?> getCache() => _getValue(_STORAGE_KEY);
  Future<String?> setCache(String? storage) => _setValue(_STORAGE_KEY, storage);

  Future<String?> getId() => _getValue(_IDENTIFICATOR_KEY);
  Future<String?> setId(String? identificator) => _setValue(_IDENTIFICATOR_KEY, identificator);
}
