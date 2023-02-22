import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/backup/bloc.dart';
import 'package:honestorage/blocs/backup/event.dart';

import 'package:honestorage/models/dataset.dart';

class InitialWidget extends StatefulWidget {
  static const String title = 'Welcome to HoneStorage!';
  static const value = ValueKey('InitialPage');
  const InitialWidget() : super(key: value);

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(InitialWidget.title),
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
