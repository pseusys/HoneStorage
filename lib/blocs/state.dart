import 'package:honestorage/models/dataset.dart';
import 'package:honestorage/models/record.dart';

class DatasetState {
  final String name;
  final String encoding;
  final List<Record> data;

  DatasetState(this.name, this.encoding, {this.data = const []});
  factory DatasetState.initial() => DatasetState("Loading...", Encoding.NONE.name);
  factory DatasetState.create() => DatasetState("New Dataset", Encoding.NONE.name);

  DatasetState copy(Dataset current) => DatasetState(
        current.name,
        current.encoding,
        data: current.data,
      );
  DatasetState copyWith({String? name, String? description, String? encoding, List<Record>? data}) => DatasetState(
        name ?? this.name,
        encoding ?? this.encoding,
        data: data ?? this.data,
      );

  DatasetState addRecord(Record current) => copyWith(data: List<Record>.from(data)..add(current));
  DatasetState removeRecord(Record current) => copyWith(data: List<Record>.from(data)..remove(current));
}
