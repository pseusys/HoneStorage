import 'package:honestorage/models/storage.dart';

class CacheState {
  final bool loading;
  final String? cacheString;
  final Storage? cacheStorage;

  CacheState(this.loading, this.cacheString, this.cacheStorage);
  factory CacheState.splash() => CacheState(true, null, null);
  factory CacheState.initial(String? serial) => CacheState(false, serial, null);
  factory CacheState.present(Storage? serial) => CacheState(false, null, serial);
}
