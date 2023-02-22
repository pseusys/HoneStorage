import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/backup/bloc.dart';
import 'package:honestorage/repositories/local.dart';

import 'package:honestorage/repositories/remote.dart';
import 'package:honestorage/navigation/information_provider.dart';
import 'package:honestorage/navigation/router_delegate.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  static const String title = 'HoneStorage';

  final local = LocalRepository();
  final remote = RemoteRepository();
  Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: local),
        RepositoryProvider.value(value: remote),
      ],
      child: BlocProvider(
        create: (context) => BackupBloc(local),
        child: MaterialApp.router(
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerDelegate: HonestRouterDelegate(),
          routeInformationParser: HonestRouteInformationParser(),
        ),
      ),
    );
  }
}
