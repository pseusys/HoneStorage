import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/models/storage.dart';
import 'package:honestorage/navigation/delegate.dart';
import 'package:honestorage/navigation/support.dart';
import 'package:honestorage/repositories/backend.dart';
import 'package:honestorage/widgets/storage.dart';
import 'package:honestorage/blocs/storage/bloc.dart';

class StoragePage extends StatelessWidget {
  static const title = 'HoneStorage';
  static const value = ValueKey('StoragePage');

  final HonestRoute state;
  final Storage cache;
  const StoragePage(this.state, this.cache) : super(key: value);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StorageBloc>(
      create: (context) => StorageBloc(context.read<BackendRepository>(), cache),
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StoragePage.title}: ${cache.name}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () async {},
            ),
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                RepositoryProvider.of<BackendRepository>(context).save("new_file.hs");
              },
            ),
            Text("Last updated: ${RepositoryProvider.of<BackendRepository>(context).updated ?? 'never'}")
          ],
        ),
        body: const StorageWidget(),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => context.delegate.showRecordAddDialog(context),
            tooltip: "Add a record",
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
