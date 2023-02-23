import 'package:honestorage/models/dataset.dart';

class BackupState {
  final bool loading;
  final String? serial;
  final Dataset? dataset;

  BackupState(this.loading, this.serial, this.dataset);
  factory BackupState.splash() => BackupState(true, null, null);
  factory BackupState.initial(String? serial) => BackupState(false, serial, null);
  factory BackupState.present(Dataset? serial) => BackupState(false, null, serial);
}
