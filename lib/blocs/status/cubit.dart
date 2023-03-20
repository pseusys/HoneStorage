import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/status/status.dart';
import 'package:honestorage/repositories/backend.dart';

class StateUnknownError extends Error {
  @override
  String toString() => "Storage state unknown error!";
}

class StatusCubit extends Cubit<BackendStatus> {
  final BackendRepository _backendRepository;
  late StreamSubscription<BackendStatus>? _backendSubscription;

  StatusCubit(this._backendRepository) : super(_backendRepository.latestStatus) {
    _backendSubscription = _backendRepository.statusStream.listen((current) => emit(current));
  }

  void save() {
    try {
      final parsed = json.decode(state.lastCache);
      _backendRepository.save(state.lastCache, "${parsed["name"] as String}.hs");
    } on FormatException catch (_) {
      return; // TODO: show user a message
    }
  }

  @override
  Future<void> close() {
    _backendSubscription?.cancel();
    return super.close();
  }
}
