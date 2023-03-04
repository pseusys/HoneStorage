import 'package:honestorage/models/format.dart';

class PhoneNumberFormat extends Format {
  static final _checker = RegExp(r'^[\+]?\d{3}?\d{3}\d{4,6}$');

  const PhoneNumberFormat();

  @override
  bool get multiline => false;

  @override
  bool get numerical => true;

  @override
  String viewPrivate(String value) => "${value.substring(0, 2)}***${value.substring(value.length - 3)}";

  @override
  String viewProtected(String value) => value;

  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
