// ignore_for_file: constant_identifier_names

part of 'storage.dart';

enum DeserializationCode { TEXT_IS_NULL, DATA_CORRUPTED, NO_PASSWORD, WRONG_PASSWORD }

class DeserializationError extends Error {
  final DeserializationCode code;
  final String _message;
  DeserializationError(this.code, this._message);

  @override
  String toString() => "Storage deserialization error: $_message";
}

dynamic _parseJson(String raw) {
  try {
    return json.decode(raw);
  } on FormatException catch (_) {
    return null;
  }
}

extension Serialization on Storage {
  String serialize(String? password, String identificator) {
    final encoded = toJson();
    encoded['signature'] = sign(encoded['encrypted']);
    if (password == null) {
      encoded['encoding'] = Encoding.NONE.name;
    } else if (encoding != Encoding.NONE.name) {
      encoded['encrypted'] = encrypt(encoded['encrypted'], identificator, password);
    }
    return json.encode(encoded);
  }

  static Storage deserialize(String? raw, String? password, String identificator) {
    if (raw == null) throw DeserializationError(DeserializationCode.TEXT_IS_NULL, "Provided text is null!");

    final decoded = _parseJson(raw);
    if (decoded == null) throw DeserializationError(DeserializationCode.DATA_CORRUPTED, "Data corrupted and can't be recovered!");

    if (decoded['encoding'] == Encoding.NONE.name) {
      final encrypted = decoded['encrypted'] as String;
      final data = _parseJson(encrypted);
      if (data == null || sign(encrypted) != decoded['signature'] as String) {
        throw DeserializationError(DeserializationCode.DATA_CORRUPTED, "Data corrupted and can't be recovered!");
      } else {
        return Storage.fromJson(decoded, data);
      }
    } else if (password == null) {
      throw DeserializationError(DeserializationCode.NO_PASSWORD, "Password is not provided!");
    } else {
      final decrypted = decrypt(decoded['encrypted'] as String, identificator, password);
      if (sign(decrypted) != decoded['signature'] as String) throw DeserializationError(DeserializationCode.WRONG_PASSWORD, "Password is incorrect!");
      final data = _parseJson(decrypted);
      if (data == null) {
        throw DeserializationError(DeserializationCode.DATA_CORRUPTED, "Data corrupted and can't be recovered!");
      } else {
        return Storage.fromJson(decoded, data);
      }
    }
  }
}
