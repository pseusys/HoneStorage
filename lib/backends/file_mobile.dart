import 'package:honestorage/backends/backend.dart';

class LocalFileHandle extends FileHandle {
  @override
  bool syncAvailable = true;

  static Future<LocalFileHandle> create() => throw UnimplementedError();

  LocalFileHandle() : super(true);

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
