import 'package:honestorage/backends/backend.dart';

class LocalFileHandle extends FileHandle {
  static bool isAvailable() => throw UnimplementedError();

  static Future<LocalFileHandle> create() => throw UnimplementedError();

  @override
  List<int> get data {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> flush() {
    // TODO: implement write
    throw UnimplementedError();
  }
}
