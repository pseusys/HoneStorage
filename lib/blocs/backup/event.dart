import 'package:honestorage/models/dataset.dart';

abstract class BackupEvent {
  const BackupEvent();
}

class BackupLoaded extends BackupEvent {
  final String? current;
  const BackupLoaded(this.current);
}

class BackupDecrypted extends BackupEvent {
  final Dataset? dataset;
  const BackupDecrypted(this.dataset);
}

class BackupSet extends BackupEvent {
  final Dataset? dataset;
  const BackupSet(this.dataset);
}
