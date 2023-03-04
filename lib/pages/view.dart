import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:honestorage/blocs/record/bloc.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/widgets/entry.dart';

class RecordViewPage extends StatelessWidget {
  RecordViewPage(int id) : super(key: ValueKey('RecordViewPageId$id'));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(SMALL_MARGIN),
        child: ListView(
          shrinkWrap: true,
          children: [
            if (state.note.isNotEmpty) MarkdownBody(data: state.note),
            for (var entry in state.entries) EntryRecordViewWidget(entry.cast()),
          ],
        ),
      ),
    );
  }
}
