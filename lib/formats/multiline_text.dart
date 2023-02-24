import 'package:honestorage/models/format.dart';

class MultilineTextFormat extends Format {
  static final _checker = RegExp(r'^[\s\S]*$');

  @override
  bool get multiline => true;

  @override
  bool get numerical => false;

  @override
  String viewPrivate(String value) => "[text]";

  @override
  String viewProtected(String value) => value;

  @override
  String viewPublic(String value) => value;

  @override
  bool check(String value) => _checker.hasMatch(value);
}
