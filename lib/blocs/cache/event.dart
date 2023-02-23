import 'package:honestorage/models/dataset.dart';

abstract class CacheEvent {
  const CacheEvent();
}

class CacheLoaded extends CacheEvent {
  final String? current;
  const CacheLoaded(this.current);
}

class CacheDecrypted extends CacheEvent {
  final Dataset? dataset;
  const CacheDecrypted(this.dataset);
}

class CacheSet extends CacheEvent {
  final Dataset? dataset;
  const CacheSet(this.dataset);
}
