import 'package:formz/formz.dart';

import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/models/record.dart';

class RecordState {
  final FormzStatus status;
  final TitleForm title;
  final NoteForm note;
  final List<EntryForm> entries;

  const RecordState._(this.entries, {this.status = FormzStatus.pure, this.title = const TitleForm.pure(), this.note = const NoteForm.pure()});
  factory RecordState.copy(Record record) =>
      RecordState._(record.entries.map((e) => EntryForm.dirty(e)).toList(), title: TitleForm.dirty(record.title), note: NoteForm.dirty(record.note));
  factory RecordState.create() => const RecordState._([], title: TitleForm.dirty(), note: NoteForm.dirty());

  RecordState copyWith({FormzStatus? status, TitleForm? title, NoteForm? note, List<EntryForm>? entries}) => RecordState._(
        entries ?? this.entries,
        status: status ?? this.status,
        title: title ?? this.title,
        note: note ?? this.note,
      );
}
