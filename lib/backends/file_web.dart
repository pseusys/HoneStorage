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
  bool syncAvailable = _isFilePickAvailable();

  @override
  final List<int> data;
  final dynamic _handler;

  LocalFileHandle(this.data, this._handler) : super(true);

  static Future<LocalFileHandle> create() async {
    final handle = await promiseToFuture(_pickFile()); // TODO: handle not picked exception.
    final content = await promiseToFuture(_loadFile(handle));
    final list = (content as ByteBuffer).asUint8List().toList();
    return LocalFileHandle(list, handle);
  }

  @override
  Future<void> flush() async {
    try {
      await promiseToFuture(_syncFile(_handler, Uint8List.fromList(data)));
    } catch (_) {
      // TODO: show user notification that synchronization was disabled.
      syncAvailable = false;
      syncEnabled = false;
    }
  }
}
