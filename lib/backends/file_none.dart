import 'package:honestorage/backends/backend.dart';

class LocalFileHandle extends FileHandle {
  @override
  bool syncAvailable = false;

  static Future<LocalFileHandle> create() => throw UnimplementedError();

  LocalFileHandle() : super(false);

  @override
  List<int> get data => throw UnimplementedError();

  @override
  Future<void> flush() => throw UnimplementedError();
}
