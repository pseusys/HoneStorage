import 'package:honestorage/models/storage.dart';
import 'package:honestorage/models/record.dart';

class StorageState {
  final String name;
  final String encoding;
  final List<Record> data;

  StorageState(this.name, this.encoding, {this.data = const []});
  factory StorageState.copy(Storage current) => StorageState(current.name, current.encoding, data: current.data);

  StorageState copyWith({String? name, String? description, String? encoding, List<Record>? data}) => StorageState(
        name ?? this.name,
        encoding ?? this.encoding,
        data: data ?? this.data,
      );

  StorageState addRecord(Record current) => copyWith(data: List<Record>.from(data)..add(current));
  StorageState removeRecord(int index) => copyWith(data: List<Record>.from(data)..removeAt(index));
  StorageState changeRecord(int index, Record current) {
    final newData = List<Record>.from(data);
    newData[index] = current;
    return copyWith(data: newData);
  }
}
