import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/backends/repository.dart';
import 'package:honestorage/blocs/bloc.dart';

import 'package:honestorage/honestorage.dart';

void main() => runApp(const Root());

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  // TODO: get backup from shared preferences.

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BackupRepository(),
      child: BlocProvider(
        create: (context) => DatasetBloc(context.read<BackupRepository>()),
        child: const HogWeedGo(),
      ),
    );
  }
}
