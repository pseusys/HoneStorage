import 'package:honestorage/formats/plain_text.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/models/format.dart';
import 'package:honestorage/misc/convertors.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  @JsonKey(name: 'format', toJson: formatToString, fromJson: stringToFormat, includeFromJson: true, includeToJson: true)
  final Format format;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'data')
  final String data;

  const Entry(this.name, this.data, this.format);
  factory Entry.create() => const Entry("", "", PlainTextFormat());
  Entry copyWith({Format? format, String? name, String? data}) => Entry(name ?? this.name, data ?? this.data, format ?? this.format);

  String get private => format.check(data) ? format.viewPrivate(data) : data;
  String get protected => format.check(data) ? format.viewProtected(data) : data;
  String get public => format.check(data) ? format.viewPublic(data) : data;
  bool get check => format.check(data);

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);

  bool equals(Entry other) => format == other.format && name == other.name && data == other.data;
}
