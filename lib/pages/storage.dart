import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/backends/backend.dart';
import 'package:honestorage/download/common.dart';

import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/navigation/delegate.dart';
import 'package:honestorage/navigation/support.dart';
import 'package:honestorage/repositories/backup.dart';
import 'package:honestorage/repositories/cache.dart';
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
    final bloc = StorageBloc(context.read<BackupRepository>(), context.read<CacheRepository>(), cache.cacheStorage!);
    return BlocProvider<StorageBloc>(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StoragePage.title}: ${cache.cacheStorage!.name}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () async {
                final file = await BACKENDS["LocalFileHandle"]!.create.call();
                file.data.addAll([110, 103, 111, 110, 101, 101]);
                await file.flush();
                file.data.addAll([110, 103, 111, 110, 101, 101]);
                await file.flush();
                file.data.addAll([110, 103, 111, 110, 101, 101]);
                await file.flush();
                save(file, "new_file.txt");
              },
            ),
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                // save(, "name.hs");
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
