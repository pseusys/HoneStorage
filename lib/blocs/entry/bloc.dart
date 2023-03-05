import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:honestorage/blocs/entry/event.dart';
import 'package:honestorage/blocs/entry/form.dart';
import 'package:honestorage/blocs/entry/state.dart';
import 'package:honestorage/blocs/record/bloc.dart';
import 'package:honestorage/blocs/record/event.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final int _index;
  final RecordBloc _recordBloc;

  EntryBloc(this._index, this._recordBloc, EntryState state) : super(state) {
    on<NameChanged>(_onNameChanged);
    on<FormatChanged>(_onFormatChanged);
    on<DataChanged>(_onDataChanged);
  }

  void _onNameChanged(NameChanged event, Emitter<EntryState> emit) {
    final ns = state.copyWith(
      name: event.name,
      status: Formz.validate([event.name, state.data]),
    );
    emit(ns);
    _recordBloc.add(RecordEntryChanged(_index, ns));
  }

  void _onFormatChanged(FormatChanged event, Emitter<EntryState> emit) {
    final data = DataForm.dirty(event.format, state.data.value);
    final ns = state.copyWith(
      format: event.format,
      data: data,
      status: Formz.validate([state.name, data]),
    );
    emit(ns);
    _recordBloc.add(RecordEntryChanged(_index, ns));
  }

  void _onDataChanged(DataChanged event, Emitter<EntryState> emit) {
    final data = DataForm.dirty(state.format, event.data);
    final ns = state.copyWith(
      data: data,
      status: Formz.validate([state.name, data]),
    );
    emit(ns);
    _recordBloc.add(RecordEntryChanged(_index, ns));
  }
}
