import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/backup/event.dart';
import 'package:honestorage/blocs/backup/state.dart';

import 'package:honestorage/repositories/local.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  final LocalRepository _localRepository;

  BackupBloc(this._localRepository) : super(BackupState.splash()) {
    on<BackupDecrypted>((event, emit) => emit(BackupState.present(event.dataset)));
    on<BackupLoaded>(_backUpLoaded);
    on<BackupSet>(_setBackup);

    _localRepository.getCache().then((value) => add(BackupLoaded(value)));
  }

  void _backUpLoaded(BackupLoaded event, Emitter<BackupState> emit) {
    // Attempt to decrypt automatically -> decrypt
    // context.read<BackupBloc>().add(BackupDecrypted(dataset)); // To decrypt dataset
    // else:
    emit(BackupState.initial(event.current));
  }

  void _setBackup(BackupSet event, Emitter<BackupState> emit) {
    _localRepository.setDataset(event.dataset).then((value) => add(BackupLoaded(value)));
  }
}
