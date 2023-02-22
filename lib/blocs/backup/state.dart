import 'package:honestorage/models/dataset.dart';

class BackupState {
  final bool loading;
  final String? datasetCache;
  final Dataset? dataset;

  BackupState(this.loading, this.datasetCache, this.dataset);
  factory BackupState.splash() => BackupState(true, null, null);
  factory BackupState.initial(String? cached) => BackupState(false, cached, null);
  factory BackupState.present(Dataset? cached) => BackupState(false, null, cached);
}
