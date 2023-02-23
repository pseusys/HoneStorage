// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static const _DATASET_KEY = "dataset";

  Future<String?> getLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_DATASET_KEY);
  }

  Future<String?> setLocal(String? dataset) async {
    final prefs = await SharedPreferences.getInstance();
    if (dataset != null) {
      prefs.setString(_DATASET_KEY, dataset);
    } else {
      prefs.remove(_DATASET_KEY);
    }
    return dataset;
  }
}
