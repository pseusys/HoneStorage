import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/cache/bloc.dart';
import 'package:honestorage/repositories/backend.dart';

import 'package:honestorage/navigation/delegate.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  static const String title = 'HoneStorage';

  final backend = BackendRepository();
  Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: backend,
      child: BlocProvider(
        create: (context) => CacheBloc(backend),
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
