// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:honestorage/misc/crypto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/misc/convertors.dart';
import 'package:honestorage/models/record.dart';

part 'serialization.dart';
part 'storage.g.dart';

enum Encoding { PIN_CODE, PASSWORD, NONE }

@JsonSerializable()
class Storage {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'encoding')
  final String encoding;
  @JsonKey(name: 'data', toJson: toNull, fromJson: emptyList, includeIfNull: false)
  final List<Record> data;

  Storage(this.name, this.encoding) : data = [];
  Storage.fromData(this.name, this.encoding, this.data);
  factory Storage.create() => Storage("New Storage", Encoding.NONE.name);

  factory Storage.fromJson(Map<String, dynamic> raw, List<dynamic> data) {
    Storage parsed = _$StorageFromJson(raw);
    parsed.data.addAll(data.map((e) => Record.fromJson(e)).toList());
    return parsed;
  }

  Map<String, dynamic> toJson() {
    var fields = _$StorageToJson(this);
    fields['encrypted'] = json.encode(data.map((e) => e.toJson()).toList());
    return fields;
  }
}
