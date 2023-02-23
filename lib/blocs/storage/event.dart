import 'package:honestorage/models/storage.dart';
import 'package:honestorage/models/record.dart';

abstract class StorageEvent {
  const StorageEvent();
}

class StorageChanged extends StorageEvent {
  final Storage current;
  const StorageChanged(this.current);
}

class NameChanged extends StorageEvent {
  final String current;
  const NameChanged(this.current);
}

class EncodingChanged extends StorageEvent {
  final String current;
  const EncodingChanged(this.current);
}

class RecordAdded extends StorageEvent {
  final Record current;
  const RecordAdded(this.current);
}

class RecordRemoved extends StorageEvent {
  final Record current;
  const RecordRemoved(this.current);
}
