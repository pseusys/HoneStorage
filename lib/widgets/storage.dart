import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/widgets/record.dart';
import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/state.dart';

class StorageWidget extends StatefulWidget {
  const StorageWidget({Key? key}) : super(key: key);

  @override
  State<StorageWidget> createState() => _StorageWidgetState();
}

class _StorageWidgetState extends State<StorageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageBloc, StorageState>(
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
              children: [for (var i = 0; i < state.data.length; i++) RecordWidget(state.data[i], i)],
            ),
          ),
        ],
      ),
    );
  }
}
