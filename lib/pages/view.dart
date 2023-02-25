import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/widgets/entry.dart';

class RecordViewPage extends StatelessWidget {
  final int id;
  final Record content;
  RecordViewPage(this.id, this.content) : super(key: ValueKey('RecordViewPageId$id'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SMALL_MARGIN),
      child: Column(
        children: [
          if (content.note.isNotEmpty) MarkdownBody(data: content.note),
          for (var entry in content.entries) EntryRecordWidget(entry),
        ],
      ),
    );
  }
}
