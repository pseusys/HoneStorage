import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/dataset/state.dart';
import 'package:honestorage/widgets/dataset.dart';

import 'package:honestorage/blocs/dataset/bloc.dart';
import 'package:honestorage/blocs/dataset/event.dart';

class DatasetPage extends StatelessWidget {
  static const title = 'HoneStorage';
  static const value = ValueKey('DatasetPage');

  const DatasetPage() : super(key: value);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatasetBloc, DatasetState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("${DatasetPage.title}: ${state.name}"),
          ),
          body: DatasetWidget(state.data),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<DatasetBloc>().add(RecordAdded(rec));
            },
            tooltip: "Add a record",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
