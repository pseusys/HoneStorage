import 'package:json_annotation/json_annotation.dart';

import 'package:honestorage/models/entry.dart';

part 'record.g.dart';

@JsonSerializable(explicitToJson: true)
class Record {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'note')
  final String note;
  @JsonKey(name: 'entries')
  final List<Entry> entries;

  const Record(this.title, this.note, this.entries);
  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
