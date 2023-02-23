import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/cache/event.dart';
import 'package:honestorage/blocs/cache/state.dart';

import 'package:honestorage/repositories/cache.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  final CacheRepository _cacheRepository;

  CacheBloc(this._cacheRepository) : super(CacheState.splash()) {
    on<CacheDecrypted>((event, emit) => emit(CacheState.present(event.current)));
    on<CacheLoaded>(_cacheLoaded);
    on<CacheSet>(_cacheSet);

    _cacheRepository.getCache().then((value) => add(CacheLoaded(value)));
  }

  void _cacheLoaded(CacheLoaded event, Emitter<CacheState> emit) {
    // Attempt to decrypt automatically -> decrypt
    // context.read<BackupBloc>().add(BackupDecrypted(storage)); // To decrypt storage
    // else:
    emit(CacheState.initial(event.current));
  }

  void _cacheSet(CacheSet event, Emitter<CacheState> emit) {
    final serial = event.current?.toJson().toString();
    _cacheRepository.setCache(serial).then((value) => add(CacheLoaded(value)));
  }
}
