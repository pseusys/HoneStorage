import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:honestorage/blocs/entry/state.dart';
import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/event.dart';

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
      status: Formz.validate([event.title, state.note, EntriesForm.dirty(state.entries)]),
    ));
  }

  void _onNoteChanged(RecordNoteChanged event, Emitter<RecordState> emit) {
    emit(state.copyWith(
      note: event.note,
      status: Formz.validate([state.title, event.note, EntriesForm.dirty(state.entries)]),
    ));
  }

  void _onEntryAdded(RecordEntryAdded event, Emitter<RecordState> emit) {
    final entries = List<EntryState>.from(state.entries)..add(event.entry);
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, EntriesForm.dirty(entries)]),
    ));
  }

  void _onEntryChanged(RecordEntryChanged event, Emitter<RecordState> emit) {
    final entries = List<EntryState>.from(state.entries);
    entries[event.index] = event.entry;
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, EntriesForm.dirty(entries)]),
    ));
  }

  void _onEntryRemoved(RecordEntryRemoved event, Emitter<RecordState> emit) {
    final entries = List<EntryState>.from(state.entries)..removeAt(event.index);
    emit(state.copyWith(
      entries: entries,
      status: Formz.validate([state.title, state.note, EntriesForm.dirty(entries)]),
    ));
  }

  void _onSubmitted(RecordSubmitted event, Emitter<RecordState> emit) {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      if (_index != null) {
        _storageBloc.add(RecordChanged(_index!, state.cast()));
      } else {
        _storageBloc.add(RecordAdded(state.cast()));
      }
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
