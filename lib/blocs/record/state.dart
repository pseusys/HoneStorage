import 'package:formz/formz.dart';
import 'package:honestorage/blocs/entry/state.dart';

import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/models/record.dart';

class RecordState {
  final FormzStatus status;
  final TitleForm title;
  final String note;
  final List<EntryState> entries;

  const RecordState._(this.entries, {this.status = FormzStatus.invalid, this.title = const TitleForm.dirty(), this.note = ""});
  factory RecordState.create() => const RecordState._([], title: TitleForm.dirty(), note: "");
  factory RecordState.copy(Record record) => RecordState._(record.entries.map((e) => EntryState.copy(e)).toList(),
      status: FormzStatus.pure, title: TitleForm.dirty(record.title), note: record.note);

  Record cast() => Record(title.value, note, entries.map((e) => e.cast()).toList());

  RecordState copyWith({FormzStatus? status, TitleForm? title, String? note, List<EntryState>? entries}) => RecordState._(
        entries ?? this.entries,
        status: status ?? this.status,
        title: title ?? this.title,
        note: note ?? this.note,
      );
}
