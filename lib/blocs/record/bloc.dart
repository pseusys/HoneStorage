import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/event.dart';
import 'package:honestorage/models/record.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final int? _index;
  final StorageBloc _storageBloc;

  RecordBloc._(this._index, this._storageBloc, RecordState state) : super(state) {
    on<RecordTitleChanged>(_onTitleChanged);
    on<RecordNoteChanged>(_onNoteChanged);
    on<RecordEntryAdded>(_onEntryAdded);
    on<RecordEntryChanged>(_onEntryChanged);
    on<RecordEntryRemoved>(_onEntryRemoved);
    on<RecordSubmitted>(_onSubmitted);
  }
  factory RecordBloc.copy(int index, StorageBloc storage) => RecordBloc._(index, storage, RecordState.copy(storage.state.data[index]));
  factory RecordBloc.create(StorageBloc storage) => RecordBloc._(null, storage, RecordState.create());

  void _onTitleChanged(RecordTitleChanged event, Emitter<RecordState> emit) {
    emit(state.copyWith(
      title: event.title,
      status: Formz.validate([event.title, state.note, for (var entry in state.entries) entry, EntriesForm.dirty(state.entries)]),
    ));
  }

  void _onNoteChanged(RecordNoteChanged event, Emitter<RecordState> emit) {
    emit(state.copyWith(
      note: event.note,
      status: Formz.validate([state.title, event.note, for (var entry in state.entries) entry, EntriesForm.dirty(state.entries)]),
    ));
  }

  void _onEntryAdded(RecordEntryAdded event, Emitter<RecordState> emit) {
    final entries = List<EntryForm>.from(state.entries)..add(event.entry);
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, for (var entry in entries) entry, EntriesForm.dirty(entries)]),
    ));
  }

  void _onEntryChanged(RecordEntryChanged event, Emitter<RecordState> emit) {
    final entries = List<EntryForm>.from(state.entries);
    entries[event.index] = event.entry;
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, for (var entry in entries) entry, EntriesForm.dirty(entries)]),
    ));
  }

  void _onEntryRemoved(RecordEntryRemoved event, Emitter<RecordState> emit) {
    final entries = List<EntryForm>.from(state.entries)..removeAt(event.index);
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, for (var entry in entries) entry, EntriesForm.dirty(entries)]),
    ));
  }

  void _onSubmitted(RecordSubmitted event, Emitter<RecordState> emit) {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final entries = state.entries.map((e) => e.value).toList();
      if (_index != null) {
        _storageBloc.add(RecordChanged(_index!, Record(state.title.value, state.note.value, entries)));
      } else {
        _storageBloc.add(RecordAdded(Record(state.title.value, state.note.value, entries)));
      }
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
