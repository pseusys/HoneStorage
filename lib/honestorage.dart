import 'dart:typed_data';

import 'package:pointycastle/export.dart';

String encrypt(String text, String key) {
  final digest = Digest('SHA-512/256');
  final key_arr = digest.process(Uint8List.fromList(key.codeUnits));
  final iv = Uint8List.fromList(const String.fromEnvironment('BUILD_SECRET').codeUnits);

  final cbc = StreamCipher('ChaCha7539/32')..init(true, ParametersWithIV(KeyParameter(key_arr), iv));

  final result = String.fromCharCodes(cbc.process(Uint8List.fromList(text.codeUnits)));
  return result;
}

String decrypt(String text, String key) {
  final digest = Digest('SHA-512/256');
  final key_arr = digest.process(Uint8List.fromList(key.codeUnits));
  final iv = Uint8List.fromList(const String.fromEnvironment('BUILD_SECRET').codeUnits);

  final cbc = StreamCipher('ChaCha7539/32')..init(false, ParametersWithIV(KeyParameter(key_arr), iv));

  final result = String.fromCharCodes(cbc.process(Uint8List.fromList(text.codeUnits)));
  return result;
}

String sign(String text) {
  final digest = Digest('Keccak/256');
  final result = String.fromCharCodes(digest.process(Uint8List.fromList(text.codeUnits)));
  return result;
}
