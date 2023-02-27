import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/storage/event.dart';
import 'package:honestorage/blocs/storage/state.dart';
import 'package:honestorage/models/storage.dart';
import 'package:honestorage/repositories/backup.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final BackupRepository _backupRepository;
  late StreamSubscription<Storage>? _storageSubscription;

  StorageBloc(this._backupRepository, Storage storage) : super(StorageState.copy(storage)) {
    on<StorageChanged>((event, emit) => emit(StorageState.copy(event.current)));
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.current)));
    on<EncodingChanged>((event, emit) => emit(state.copyWith(encoding: event.current)));
    on<RecordAdded>((event, emit) => emit(state.addRecord(event.current)));
    on<RecordChanged>((event, emit) => emit(state.changeRecord(event.index, event.current)));
    on<RecordRemoved>((event, emit) => emit(state.removeRecord(event.index)));

    _storageSubscription = _backupRepository.storage.listen((current) => add(StorageChanged(current)));
  }

  bool get sync => _backupRepository.synchronized;

  @override
  Future<void> close() {
    _storageSubscription?.cancel();
    return super.close();
  }
}
