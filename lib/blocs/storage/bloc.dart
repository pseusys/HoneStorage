import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/storage/event.dart';
import 'package:honestorage/blocs/storage/state.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/models/storage.dart';
import 'package:honestorage/repositories/backend.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final BackendRepository _backendRepository;

  StorageBloc(this._backendRepository, Storage storage) : super(StorageState.copy(storage)) {
    on<StorageChanged>(_onStorageChanged);
    on<NameChanged>(_onNameChanged);
    on<EncodingChanged>(_onEncodingChanged);
    on<RecordAdded>(_onRecordAdded);
    on<RecordChanged>(_onRecordChanged);
    on<RecordRemoved>(_onRecordRemoved);
  }

  void _onStorageChanged(StorageChanged event, Emitter<StorageState> emit) async {
    emit(StorageState.copy(event.current));
    await _backendRepository.flushCache(state.cast());
  }

  void _onNameChanged(NameChanged event, Emitter<StorageState> emit) async {
    emit(state.copyWith(name: event.current));
    await _backendRepository.flushCache(state.cast());
  }

  void _onEncodingChanged(EncodingChanged event, Emitter<StorageState> emit) async {
    emit(state.copyWith(encoding: event.current));
    await _backendRepository.flushCache(state.cast());
  }

  void _onRecordAdded(RecordAdded event, Emitter<StorageState> emit) async {
    final data = List<Record>.from(state.data)..add(event.current);
    emit(state.copyWith(data: data));
    await _backendRepository.flushCache(state.cast());
  }

  void _onRecordChanged(RecordChanged event, Emitter<StorageState> emit) async {
    final data = List<Record>.from(state.data);
    data[event.index] = event.current;
    emit(state.copyWith(data: data));
    await _backendRepository.flushCache(state.cast());
  }

  void _onRecordRemoved(RecordRemoved event, Emitter<StorageState> emit) async {
    final data = List<Record>.from(state.data)..removeAt(event.index);
    emit(state.copyWith(data: data));
    await _backendRepository.flushCache(state.cast());
  }
}
