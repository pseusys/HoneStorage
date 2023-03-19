// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

Future<void> savePlatform(List<int> file, String name) async {
  AnchorElement(href: Uri.dataFromBytes(file).toString())
    ..setAttribute("download", name)
    ..style.display = "none"
    ..click();
}
