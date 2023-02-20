import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/event.dart';
import 'package:honestorage/blocs/state.dart';
import 'package:honestorage/models/dataset.dart';
import 'package:honestorage/backends/repository.dart';

class DatasetBloc extends Bloc<DatasetEvent, DatasetState> {
  final BackupRepository _backupRepository;
  late StreamSubscription<Dataset>? _datasetSubscription;

  DatasetBloc(this._backupRepository) : super(DatasetState.initial()) {
    on<DatasetChanged>((event, emit) => emit(state.copy(event.current)));
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.current)));
    on<EncodingChanged>((event, emit) => emit(state.copyWith(encoding: event.current)));
    on<RecordAdded>((event, emit) => emit(state.addRecord(event.current)));
    on<RecordRemoved>((event, emit) => emit(state.removeRecord(event.current)));

    _datasetSubscription = _backupRepository.dataset.listen((current) => add(DatasetChanged(current)));
  }

  bool get sync => _backupRepository.synchronized;

  @override
  Future<void> close() {
    _datasetSubscription?.cancel();
    return super.close();
  }
}
