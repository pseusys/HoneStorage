import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/event.dart';
import 'package:honestorage/models/record.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final int _index;
  final StorageBloc _storageBloc;

  RecordBloc(this._index, this._storageBloc) : super(RecordState.copy(_storageBloc.state.data[_index])) {
    on<RecordTitleChanged>(_onTitleChanged);
    on<RecordNoteChanged>(_onNoteChanged);
    on<RecordEntriesChanged>(_onEntriesChanged);
    on<RecordSubmitted>(_onSubmitted);
  }

  int get idx => _index;

  void _onTitleChanged(RecordTitleChanged event, Emitter<RecordState> emit) {
    final title = TitleForm.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.note, for (var photo in state.entries) photo, EntriesForm.dirty(state.entries)]),
    ));
  }

  void _onNoteChanged(RecordNoteChanged event, Emitter<RecordState> emit) {
    final note = NoteForm.dirty(event.note);
    emit(state.copyWith(
      note: note,
      status: Formz.validate([state.title, note, for (var photo in state.entries) photo, EntriesForm.dirty(state.entries)]),
    ));
  }

  void _onEntriesChanged(RecordEntriesChanged event, Emitter<RecordState> emit) {
    final entries = event.entries.map((e) => EntryForm.dirty(e)).toList();
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, for (var photo in entries) photo, EntriesForm.dirty(entries)]),
    ));
  }

  void _onSubmitted(RecordSubmitted event, Emitter<RecordState> emit) {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final entries = state.entries.map((e) => e.value).toList();
      if (_index != -1) {
        _storageBloc.add(RecordChanged(_index, Record(state.title.value, state.note.value, entries)));
      } else {
        _storageBloc.add(RecordAdded(Record(state.title.value, state.note.value, entries)));
      }
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
