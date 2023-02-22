// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:honestorage/models/dataset.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static const _DATASET_KEY = "dataset";
  String? _dataString;
  Dataset? _dataSet;

  Future<String?> getCache() async {
    if (_dataString == null) {
      final prefs = await SharedPreferences.getInstance();
      _dataString = prefs.getString(_DATASET_KEY);
    }
    return _dataString;
  }

  Future<Dataset?> getDecrypted(String key) async {
    _dataSet = _dataString == null ? null : json.decode(_dataString!);
    return _dataSet;
  }

  Future<String?> setDataset(Dataset? dataset) async {
    _dataSet = dataset;
    _dataString = dataset?.toJson().toString();
    final prefs = await SharedPreferences.getInstance();
    if (_dataString != null) {
      prefs.setString(_DATASET_KEY, _dataString!);
    } else {
      prefs.remove(_DATASET_KEY);
    }
    return _dataString;
  }
}
