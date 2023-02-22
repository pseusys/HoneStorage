import 'package:honestorage/models/dataset.dart';
import 'package:honestorage/models/record.dart';

abstract class DatasetEvent {
  const DatasetEvent();
}

class DatasetChanged extends DatasetEvent {
  final Dataset current;
  const DatasetChanged(this.current);
}

class NameChanged extends DatasetEvent {
  final String current;
  const NameChanged(this.current);
}

class EncodingChanged extends DatasetEvent {
  final String current;
  const EncodingChanged(this.current);
}

class RecordAdded extends DatasetEvent {
  final Record current;
  const RecordAdded(this.current);
}

class RecordRemoved extends DatasetEvent {
  final Record current;
  const RecordRemoved(this.current);
}
