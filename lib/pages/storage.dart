import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/backends/download.dart';

import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/navigation/delegate.dart';
import 'package:honestorage/navigation/support.dart';
import 'package:honestorage/repositories/backup.dart';
import 'package:honestorage/widgets/storage.dart';
import 'package:honestorage/blocs/storage/bloc.dart';

class StoragePage extends StatelessWidget {
  static const title = 'HoneStorage';
  static const value = ValueKey('StoragePage');

  final HonestRoute state;
  final CacheState cache;
  const StoragePage(this.state, this.cache) : super(key: value);

  @override
  Widget build(BuildContext context) {
    final bloc = StorageBloc(context.read<BackupRepository>(), cache.cacheStorage!);
    return BlocProvider<StorageBloc>(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StoragePage.title}: ${cache.cacheStorage!.name}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                final file = await load();
                file.data.addAll([110, 103, 111, 110, 101, 101]);
                await sync(file);
                file.data.addAll([110, 103, 111, 110, 101, 101]);
                await sync(file);
                file.data.addAll([110, 103, 111, 110, 101, 101]);
                await sync(file);
                save(file, "new_file.txt");
              },
            ),
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
