@JS()
library file_sync.js;

import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'package:honestorage/backends/backend.dart';

@JS("isFilePickAvailable")
external dynamic _isFilePickAvailable();

@JS("pickFile")
external dynamic _pickFile();

@JS("loadFile")
external dynamic _loadFile(dynamic handle);

@JS("syncFile")
external dynamic _syncFile(dynamic handle, Uint8List data);

class LocalFileHandle extends FileHandle {
  @override
  final List<int> data;
  final dynamic _handler;

  LocalFileHandle(this.data, this._handler);

  static bool isAvailable() => _isFilePickAvailable();

  static Future<LocalFileHandle> create() async {
    final handle = await promiseToFuture(_pickFile());
    final content = await promiseToFuture(_loadFile(handle));
    final list = (content as ByteBuffer).asUint8List().toList();
    return LocalFileHandle(list, handle);
  }

  @override
  Future<void> flush() async {
    await promiseToFuture(_syncFile(_handler, Uint8List.fromList(data)));
  }
}
