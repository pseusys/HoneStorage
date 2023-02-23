// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/misc/convertors.dart';
import 'package:honestorage/models/record.dart';

part 'storage.g.dart';

enum Encoding { PIN_CODE, PASSWORD, NONE }

@JsonSerializable()
class Storage {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'encoding')
  final String encoding;
  @JsonKey(name: 'signature')
  final String signature;
  @JsonKey(name: 'data', toJson: toNull, fromJson: emptyList, includeIfNull: false)
  final List<Record> data;

  Storage(this.name, this.encoding, this.signature) : data = [];
  factory Storage.create() => Storage("New Storage", Encoding.NONE.name, "");

  Storage fromJson(Map<String, dynamic> json) {
    Storage parsed = _$StorageFromJson(json);
    parsed.data;
    return parsed;
  }

  Map<String, dynamic> toJson() {
    var fields = _$StorageToJson(this);
    fields['encrypted'] = "";
    return fields;
  }
}
