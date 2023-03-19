// ignore_for_file: unused_import

import 'package:honestorage/backends/backend.dart';
import 'package:honestorage/download/none.dart'
    if (dart.library.io) 'package:honestorage/download/mobile.dart'
    if (dart.library.html) 'package:honestorage/download/web.dart';

Future<void> save(FileHandle file, String name) => savePlatform(file.data, name);
