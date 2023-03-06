// ignore_for_file: avoid_web_libraries_in_flutter

@JS()
library file_sync.js;

import 'dart:html';
import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS()
external dynamic pickFile();

@JS()
external dynamic loadFile(dynamic handle);

@JS()
external dynamic syncFile(dynamic handle, Uint8List data);

class FileHandle {
  final List<int> data;
  final dynamic handler;

  FileHandle(this.data, this.handler);
}

Future<void> save(FileHandle handle, String name) async {
  AnchorElement(href: Uri.dataFromBytes(handle.data).toString())
    ..setAttribute("download", name)
    ..style.display = "none"
    ..click();
}

Future<FileHandle> load() async {
  final handle = await promiseToFuture(pickFile());
  final content = await promiseToFuture(loadFile(handle));
  final list = (content as ByteBuffer).asUint8List().toList();
  return FileHandle(list, handle);
}

Future<void> sync(FileHandle handle) async {
  await promiseToFuture(syncFile(handle.handler, Uint8List.fromList(handle.data)));
}
