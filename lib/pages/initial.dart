import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/cache/bloc.dart';
import 'package:honestorage/blocs/cache/event.dart';

import 'package:honestorage/models/storage.dart';

class InitialPage extends StatelessWidget {
  static const String title = 'Welcome to HoneStorage!';
  static const value = ValueKey('InitialPage');
  const InitialPage() : super(key: value);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => context.read<CacheBloc>().add(CacheDecrypted(Storage.create())),
              child: const Text("Create storage"),
            ),
          ],
        ),
      ),
    );
  }
}
