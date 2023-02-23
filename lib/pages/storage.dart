import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/navigation/delegate.dart';
import 'package:honestorage/repositories/backup.dart';
import 'package:honestorage/widgets/storage.dart';

import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/event.dart';

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
      create: (ctx) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${StoragePage.title}: ${cache.cacheStorage!.name}"),
        ),
        body: const StorageWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => bloc.add(RecordAdded(rec)),
          tooltip: "Add a record",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
