import 'package:honestorage/models/dataset.dart';

abstract class BackupBackend {
  bool get synchronized => false;
  Stream<Dataset> get dataset;
  void synchronize(Dataset dataset);
}

class BackupRepository {
  BackupBackend? _backend;

  bool get synchronized => _backend != null;
  Stream<Dataset> get dataset => _backend?.dataset ?? const Stream.empty();

  void synchronize(Dataset dataset) => _backend?.synchronize ?? {throw UnimplementedError("Backup repository not synchronized!")};
}
