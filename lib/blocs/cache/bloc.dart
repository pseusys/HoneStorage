import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/cache/event.dart';
import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/models/storage.dart';

import 'package:honestorage/repositories/cache.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  final CacheRepository _cacheRepository;

  CacheBloc(this._cacheRepository) : super(CacheState.splash()) {
    on<CacheDecrypted>((event, emit) => emit(CacheState.present(event.current)));
    on<CacheLoaded>(_cacheLoaded);
    on<CacheSet>(_cacheSet);

    _cacheRepository.getCache().then((value) => add(CacheLoaded.plain(value)));
  }

  Future<void> _cacheLoaded(CacheLoaded event, Emitter<CacheState> emit) async {
    try {
      print("RECV: ${event.current}");
      final storage = Serialization.deserialize(event.current, _cacheRepository.password, _cacheRepository.identificator!);
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

  void _cacheSet(CacheSet event, Emitter<CacheState> emit) {
    final serial = event.current?.toJson().toString();
    _cacheRepository.setCache(serial).then((value) => add(CacheLoaded.plain(value)));
  }
}
