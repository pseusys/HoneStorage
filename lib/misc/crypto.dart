import 'dart:typed_data';

import 'package:pointycastle/api.dart';

final _digestSHA = Digest('SHA-512/256');
final _digestKeccak = Digest('Keccak/256');
final _cipherChaCha = StreamCipher('ChaCha7539/32');

String _processCipher(String text, String id, String password, bool encode) {
  final key = _digestSHA.process(Uint8List.fromList(password.codeUnits));
  final vector = _digestSHA.process(Uint8List.fromList(id.codeUnits));
  _digestSHA.reset();

  _cipherChaCha.init(true, ParametersWithIV(KeyParameter(key), vector));
  final result = String.fromCharCodes(_cipherChaCha.process(Uint8List.fromList(text.codeUnits)));
  _cipherChaCha.reset();

  return result;
}

String encrypt(String text, String id, String password) => _processCipher(text, id, password, true);
String decrypt(String text, String id, String password) => _processCipher(text, id, password, false);

String sign(String text) {
  final result = String.fromCharCodes(_digestKeccak.process(Uint8List.fromList(text.codeUnits)));
  _digestKeccak.reset();
  return result;
}
