import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/status/cubit.dart';
import 'package:honestorage/blocs/status/status.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StorageBloc(RepositoryProvider.of<BackendRepository>(context), cache)),
        BlocProvider(create: (context) => StatusCubit(RepositoryProvider.of<BackendRepository>(context))),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<StatusCubit, BackendStatus>(
            builder: (context, state) {
              return AppBar(
                title: Text("${StoragePage.title}: ${cache.name}"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.sync),
                    onPressed: () async {}, // TODO: setup backup in runtime.
                  ),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => BlocProvider.of<StatusCubit>(context).save(),
                  ),
                  Text("Last updated: ${state.updated.toLocal()}")
                ],
              );
            },
          ),
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
