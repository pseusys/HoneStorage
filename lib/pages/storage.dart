import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/storage/state.dart';
import 'package:honestorage/widgets/storage.dart';

import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/event.dart';

class StoragePage extends StatelessWidget {
  static const title = 'HoneStorage';
  static const value = ValueKey('StoragePage');

  const StoragePage() : super(key: value);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageBloc, StorageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("${StoragePage.title}: ${state.name}"),
          ),
          body: StorageWidget(state.data),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<StorageBloc>().add(RecordAdded(rec));
            },
            tooltip: "Add a record",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
