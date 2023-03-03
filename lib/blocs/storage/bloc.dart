import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/storage/event.dart';
import 'package:honestorage/blocs/storage/state.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/models/storage.dart';
import 'package:honestorage/repositories/backup.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final BackupRepository _backupRepository;
  late StreamSubscription<Storage>? _storageSubscription;

  StorageBloc(this._backupRepository, Storage storage) : super(StorageState.copy(storage)) {
    on<StorageChanged>((event, emit) => emit(StorageState.copy(event.current)));
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.current)));
    on<EncodingChanged>((event, emit) => emit(state.copyWith(encoding: event.current)));
    on<RecordAdded>(_onRecordAdded);
    on<RecordChanged>(_onRecordChanged);
    on<RecordRemoved>(_onRecordRemoved);

    _storageSubscription = _backupRepository.storage.listen((current) => add(StorageChanged(current)));
  }

  bool get sync => _backupRepository.synchronized;

  void _onRecordAdded(RecordAdded event, Emitter<StorageState> emit) {
    final data = List<Record>.from(state.data)..add(event.current);
    emit(state.copyWith(data: data));
  }

  void _onRecordChanged(RecordChanged event, Emitter<StorageState> emit) {
    final data = List<Record>.from(state.data);
    data[event.index] = event.current;
    emit(state.copyWith(data: data));
  }

  void _onRecordRemoved(RecordRemoved event, Emitter<StorageState> emit) {
    final data = List<Record>.from(state.data)..removeAt(event.index);
    emit(state.copyWith(data: data));
  }

  @override
  Future<void> close() {
    _storageSubscription?.cancel();
    return super.close();
  }
}
