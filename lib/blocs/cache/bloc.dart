import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/cache/event.dart';
import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/models/storage.dart';
import 'package:honestorage/repositories/backend.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  final BackendRepository _backendRepository;

  CacheBloc(this._backendRepository) : super(CacheState.splash()) {
    on<CacheDecrypted>((event, emit) => emit(CacheState.present(event.current)));
    on<CacheHandled>(_cacheHandled);
    on<CacheLoaded>(_cacheLoaded);

    _backendRepository.getCache().then((value) => add(CacheLoaded.plain(value)));
  }

  Future<void> _cacheLoaded(CacheLoaded event, Emitter<CacheState> emit) async {
    try {
      final storage = Serialization.deserialize(event.current, _backendRepository.password, _backendRepository.identificator!);
      emit(CacheState.present(storage));
    } on DeserializationError catch (error) {
      switch (error.code) {
        case DeserializationCode.DATA_CORRUPTED:
          emit(CacheState.initial(null));
          // Found data corrupted, print a message and redirect to initial screen.
          break;
        case DeserializationCode.NO_PASSWORD:
          emit(CacheState.initial(event.current));
          // Data encrypted, ask for password.
          break;
        case DeserializationCode.TEXT_IS_NULL:
          emit(CacheState.initial(null));
          // No saved data is found, redirecting to initial screen.
          break;
        case DeserializationCode.WRONG_PASSWORD:
          emit(CacheState.initial(event.current));
          // Password incorrect, ask for passwotrd once again.
          break;
        default:
      }
    }
  }

  Future<void> _cacheHandled(CacheHandled event, Emitter<CacheState> emit) async {
    final cache = await _backendRepository.setBackend(event.current);
    add(CacheLoaded.plain(cache));
  }
}
