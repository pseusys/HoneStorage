import 'package:honestorage/models/dataset.dart';

class CacheState {
  final bool loading;
  final String? cacheString;
  final Dataset? dataset;

  CacheState(this.loading, this.cacheString, this.dataset);
  factory CacheState.splash() => CacheState(true, null, null);
  factory CacheState.initial(String? serial) => CacheState(false, serial, null);
  factory CacheState.present(Dataset? serial) => CacheState(false, null, serial);
}
