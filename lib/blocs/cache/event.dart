import 'package:honestorage/models/storage.dart';

abstract class CacheEvent {
  const CacheEvent();
}

class CacheLoaded extends CacheEvent {
  final String? current;
  final String? password;
  CacheLoaded.plain(this.current) : password = null;
  CacheLoaded.present(this.current, this.password);
}

class CacheDecrypted extends CacheEvent {
  final Storage? current;
  const CacheDecrypted(this.current);
}

class CacheSet extends CacheEvent {
  final Storage? current;
  const CacheSet(this.current);
}
