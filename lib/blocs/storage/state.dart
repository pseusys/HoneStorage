import 'package:honestorage/models/storage.dart';
import 'package:honestorage/models/record.dart';

class StorageState {
  final String name;
  final String encoding;
  final List<Record> data;

  StorageState(this.name, this.encoding, {this.data = const []});
  factory StorageState.copy(Storage current) => StorageState(current.name, current.encoding, data: current.data);
  Storage cast() => Storage.fromData(name, encoding, data);

  StorageState copyWith({String? name, String? description, String? encoding, List<Record>? data}) => StorageState(
        name ?? this.name,
        encoding ?? this.encoding,
        data: data ?? this.data,
      );
}
