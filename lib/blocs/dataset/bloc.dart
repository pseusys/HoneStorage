import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/dataset/event.dart';
import 'package:honestorage/blocs/dataset/state.dart';
import 'package:honestorage/models/dataset.dart';
import 'package:honestorage/repositories/remote.dart';

class DatasetBloc extends Bloc<DatasetEvent, DatasetState> {
  final RemoteRepository _remoteRepository;
  late StreamSubscription<Dataset>? _datasetSubscription;

  DatasetBloc(this._remoteRepository, Dataset dataset) : super(DatasetState.copy(dataset)) {
    on<DatasetChanged>((event, emit) => emit(DatasetState.copy(event.current)));
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.current)));
    on<EncodingChanged>((event, emit) => emit(state.copyWith(encoding: event.current)));
    on<RecordAdded>((event, emit) => emit(state.addRecord(event.current)));
    on<RecordRemoved>((event, emit) => emit(state.removeRecord(event.current)));

    _datasetSubscription = _remoteRepository.dataset.listen((current) => add(DatasetChanged(current)));
  }

  bool get sync => _remoteRepository.synchronized;

  @override
  Future<void> close() {
    _datasetSubscription?.cancel();
    return super.close();
  }
}
