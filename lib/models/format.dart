// ignore_for_file: non_constant_identifier_names

import 'package:honestorage/formats/phone_number.dart';

abstract class Format {
  abstract final bool multiline;
  String convert(String value);
}

final Map<String, Format Function()> FORMATS = {
  (PhoneNumberFormat).toString(): () => PhoneNumberFormat(),
};
