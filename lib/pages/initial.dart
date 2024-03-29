import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/backends/backend.dart';
import 'package:honestorage/blocs/cache/bloc.dart';
import 'package:honestorage/blocs/cache/event.dart';

class InitialPage extends StatelessWidget {
  static const String title = 'Welcome to HoneStorage!';
  static const value = ValueKey('InitialPage');
  const InitialPage() : super(key: value);

  @override
  Widget build(BuildContext context) {
    final cahceBloc = BlocProvider.of<CacheBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(InitialPage.title),
      ),
      body: Center(
        child: Column(
          children: [
            const Icon(
              Icons.hive,
              color: Colors.amber,
              size: 32.0,
            ),
            const Text("Init app"),
            TextButton(
              onPressed: () => cahceBloc.add(CacheHandled(null)),
              child: const Text("Create storage"),
            ),
            for (var backend in BACKENDS.values)
              TextButton(
                onPressed: () => backend.create.call().then((value) => cahceBloc.add(CacheHandled(value))),
                child: Text("Open ${backend.name}"),
              ),
          ],
        ),
      ),
    );
  }
}
