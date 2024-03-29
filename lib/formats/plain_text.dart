import 'package:honestorage/formats/format.dart';

class PlainTextFormat extends Format {
  static final _checker = RegExp(r'^[^\n]+$');

  const PlainTextFormat();

  @override
  bool get multiline => false;

  @override
  bool get numerical => false;

  @override
  String viewPrivate(String value) => "[line]";

  @override
  String viewProtected(String value) => value;

  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
