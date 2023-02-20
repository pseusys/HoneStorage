// ignore_for_file: non_constant_identifier_names

import 'package:honestorage/formats/bank_card.dart';
import 'package:honestorage/formats/multiline_text.dart';
import 'package:honestorage/formats/password.dart';
import 'package:honestorage/formats/phone_number.dart';
import 'package:honestorage/formats/plain_text.dart';

abstract class Format {
  abstract final bool multiline;
  abstract final bool numerical;
  String viewPrivate(String value);
  String viewProtected(String value);
  String viewPublic(String value);
  bool check(String value);
}

final Map<String, Format Function()> FORMATS = {
  (BankCardFormat).toString(): () => BankCardFormat(),
  (MultilineTextFormat).toString(): () => MultilineTextFormat(),
  (PasswordFormat).toString(): () => PasswordFormat(),
  (PhoneNumberFormat).toString(): () => PhoneNumberFormat(),
  (PlainTextFormat).toString(): () => PlainTextFormat(),
};
