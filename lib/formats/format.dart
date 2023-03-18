// ignore_for_file: non_constant_identifier_names

import 'package:honestorage/formats/bank_card.dart';
import 'package:honestorage/formats/email_address.dart';
import 'package:honestorage/formats/multiline_text.dart';
import 'package:honestorage/formats/password.dart';
import 'package:honestorage/formats/phone_number.dart';
import 'package:honestorage/formats/pin_code.dart';
import 'package:honestorage/formats/plain_text.dart';

abstract class Format {
  const Format();
  abstract final bool multiline;
  abstract final bool numerical;
  String viewPrivate(String value);
  String viewProtected(String value);
  String viewPublic(String value);
  bool check(String value);
}

class FormatDescription {
  final Format format;
  final String description;

  FormatDescription(this.format, this.description);
}

final Map<String, FormatDescription> FORMATS = {
  (BankCardFormat).toString(): FormatDescription(const BankCardFormat(), "Bank card number"),
  (EmailAddressFormat).toString(): FormatDescription(const EmailAddressFormat(), "Email address"),
  (MultilineTextFormat).toString(): FormatDescription(const MultilineTextFormat(), "Multiline text"),
  (PasswordFormat).toString(): FormatDescription(const PasswordFormat(), "Password"),
  (PhoneNumberFormat).toString(): FormatDescription(const PhoneNumberFormat(), "Phone number"),
  (PINCodeFormat).toString(): FormatDescription(const PINCodeFormat(), "PIN code"),
  (PlainTextFormat).toString(): FormatDescription(const PlainTextFormat(), "Plain text"),
};
