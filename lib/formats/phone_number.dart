import 'package:honestorage/models/format.dart';

class PhoneNumberFormat extends Format {
  @override
  String convert(String value) {
    return value;
  }

  @override
  bool get multiline => false;
}
