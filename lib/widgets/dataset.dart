import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/blocs/bloc.dart';
import 'package:honestorage/blocs/state.dart';
import 'package:honestorage/widgets/record.dart';

class DatasetWidget extends StatefulWidget {
  const DatasetWidget({Key? key}) : super(key: key);

  @override
  State<DatasetWidget> createState() => _DatasetWidgetState();
}

class _DatasetWidgetState extends State<DatasetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatasetBloc, DatasetState>(
      builder: (context, state) => CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ReorderableWrap(
              spacing: MEDIUM_MARGIN,
              runSpacing: MEDIUM_MARGIN,
              alignment: WrapAlignment.spaceEvenly,
              padding: const EdgeInsets.all(MEDIUM_MARGIN),
              onReorder: (o, n) => setState(() => state.data.insert(n, state.data.removeAt(o))),
              children: [for (var record in state.data) RecordWidget(record)],
            ),
          ),
        ],
      ),
    );
  }
}
