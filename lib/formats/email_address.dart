import 'package:honestorage/models/format.dart';

class EmailAddressFormat extends Format {
  static final _checker = RegExp(r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$");

  const EmailAddressFormat();

  @override
  bool get multiline => false;

  @override
  bool get numerical => false;

  @override
  String viewPrivate(String value) => "${value.substring(0, 3)}***${value.substring(value.length - 2)}";

  @override
  String viewProtected(String value) => value;

  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
