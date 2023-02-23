// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class CacheRepository {
  static const _DATASET_KEY = "dataset";

  Future<String?> getCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_DATASET_KEY);
  }

  Future<String?> setCache(String? dataset) async {
    final prefs = await SharedPreferences.getInstance();
    if (dataset != null) {
      prefs.setString(_DATASET_KEY, dataset);
    } else {
      prefs.remove(_DATASET_KEY);
    }
    return dataset;
  }
}
