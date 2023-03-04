import 'package:honestorage/models/format.dart';

class PINCodeFormat extends Format {
  static final _checker = RegExp(r'^\d+$');

  const PINCodeFormat();

  @override
  bool get multiline => false;

  @override
  bool get numerical => true;

  @override
  String viewPrivate(String value) => "****";

  @override
  String viewProtected(String value) => "****";
  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
