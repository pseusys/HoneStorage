import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/backup/bloc.dart';
import 'package:honestorage/blocs/backup/event.dart';

import 'package:honestorage/models/dataset.dart';

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
              onPressed: () => context.read<BackupBloc>().add(BackupDecrypted(Dataset.create())),
              child: const Text("Create dataset"),
            ),
          ],
        ),
      ),
    );
  }
}
