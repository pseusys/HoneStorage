import 'package:honestorage/models/storage.dart';

abstract class BackupBackend {
  bool get synchronized => false;
  Stream<Storage> get storage;
  void synchronize(Storage storage);
}

class BackupRepository {
  BackupBackend? _backend;

  bool get synchronized => _backend != null;
  Stream<Storage> get storage => _backend?.storage ?? const Stream.empty();

  void synchronize(Storage storage) => _backend?.synchronize ?? {throw UnimplementedError("Backup repository not synchronized!")};
}
