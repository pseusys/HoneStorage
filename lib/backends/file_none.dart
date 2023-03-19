import 'package:honestorage/backends/backend.dart';

class LocalFileHandle extends FileHandle {
  static bool isAvailable() => false;

  static Future<LocalFileHandle> create() => throw UnimplementedError();

  @override
  List<int> get data => throw UnimplementedError();

  @override
  Future<void> flush() => throw UnimplementedError();
}
