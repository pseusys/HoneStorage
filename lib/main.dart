import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/cache/bloc.dart';
import 'package:honestorage/repositories/cache.dart';

import 'package:honestorage/repositories/backup.dart';
import 'package:honestorage/navigation/delegate.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  static const String title = 'HoneStorage';

  final cache = CacheRepository();
  final backup = BackupRepository();
  Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: cache),
        RepositoryProvider.value(value: backup),
      ],
      child: BlocProvider(
        create: (context) => CacheBloc(cache),
        child: MaterialApp.router(
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerDelegate: HonestRouterDelegate(),
        ),
      ),
    );
  }
}
