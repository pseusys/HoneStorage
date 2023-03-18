import 'package:honestorage/formats/format.dart';

toNull(_) => null;

emptyList(_) => [];

formatToString(Format format) => format.runtimeType.toString();
stringToFormat(String format) => FORMATS[format]!.format;
