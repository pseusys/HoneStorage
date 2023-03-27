// ignore_for_file: non_constant_identifier_names

import 'package:honestorage/backends/file_none.dart'
    if (dart.library.io) 'package:honestorage/backends/file_mobile.dart'
    if (dart.library.html) 'package:honestorage/backends/file_web.dart';

abstract class FileHandle {
  bool get syncAvailable;
  bool syncEnabled;

  FileHandle(this.syncEnabled);

  List<int> get data;

  String get contents => String.fromCharCodes(data);

  Future<void> flush();

  Future<void> populate(String? contents) async {
    data.clear();
    if (contents != null) data.addAll(contents.codeUnits);
    await flush();
  }
}

// TODO: handle is not preserved on page reload.
class FileHandleDescription {
  final String name;
  final Future<FileHandle> Function() create;

  FileHandleDescription(this.name, this.create);
}

final Map<String, FileHandleDescription> BACKENDS = {
  (LocalFileHandle).toString(): FileHandleDescription("file storage", LocalFileHandle.create),
};
