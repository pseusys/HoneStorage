import 'dart:typed_data';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';

Future<void> savePlatform(List<int> file, String name) async {
  final params = SaveFileDialogParams(data: Uint8List.fromList(file), fileName: name);
  await FlutterFileDialog.saveFile(params: params);
}
