// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/misc/convertors.dart';
import 'package:honestorage/models/record.dart';

part 'dataset.g.dart';

enum Encoding { PIN_CODE, PASSWORD, NONE }

@JsonSerializable()
class Dataset {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'encoding')
  final String encoding;
  @JsonKey(name: 'signature')
  final String signature;
  @JsonKey(name: 'data', toJson: toNull, fromJson: emptyList, includeIfNull: false)
  final List<Record> data;

  Dataset(this.name, this.encoding, this.signature) : data = [];

  Dataset fromJson(Map<String, dynamic> json) {
    Dataset parsed = _$DatasetFromJson(json);
    parsed.data;
    return parsed;
  }

  Map<String, dynamic> toJson() {
    var fields = _$DatasetToJson(this);
    fields['encrypted'] = "";
    return fields;
  }
}
