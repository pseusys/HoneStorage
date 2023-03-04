import 'package:honestorage/models/format.dart';

class BankCardFormat extends Format {
  static final _checker = RegExp(r'^\d{16}$');

  const BankCardFormat();

  @override
  bool get multiline => false;

  @override
  bool get numerical => true;

  @override
  String viewPrivate(String value) => "**** ${value.substring(value.length - 4)}";

  @override
  String viewProtected(String value) => value;

  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
