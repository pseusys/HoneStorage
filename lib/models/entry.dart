import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/models/format.dart';
import 'package:honestorage/misc/convertors.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  @JsonKey(name: 'format', toJson: formatToString, fromJson: stringToFormat)
  final Format format;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'data')
  final String data;

  const Entry(this.format, this.name, this.data);

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
