import 'package:honestorage/models/format.dart';

class PasswordFormat extends Format {
  static final _checker = RegExp(r'^[^\n]*');

  @override
  bool get multiline => false;

  @override
  bool get numerical => false;

  @override
  String viewPrivate(String value) => "****";

  @override
  String viewProtected(String value) => "****";
  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
