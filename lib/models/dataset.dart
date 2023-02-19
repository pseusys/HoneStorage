import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/misc/convertors.dart';
import 'package:honestorage/models/record.dart';

part 'dataset.g.dart';

@JsonSerializable()
class Dataset {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'data', toJson: toNull, fromJson: emptyList, includeIfNull: false)
  final List<Record> data;

  Dataset(this.name, this.code, this.key) : data = [];

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
