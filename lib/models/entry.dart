import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/models/format.dart';
import 'package:honestorage/misc/convertors.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  @JsonKey(name: 'format', toJson: formatToString, fromJson: stringToFormat, includeFromJson: true, includeToJson: true)
  final Format _format;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'data')
  final String data;

  const Entry(this.name, this.data, this._format);

  String get private => _format.check(data) ? _format.viewPrivate(data) : data;
  String get protected => _format.check(data) ? _format.viewProtected(data) : data;
  String get public => _format.check(data) ? _format.viewPublic(data) : data;
  bool get check => _format.check(data);

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
