import 'package:flutter/material.dart';

import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/navigation/support.dart';
import 'package:honestorage/widgets/entry.dart';

class RecordWidget extends StatelessWidget {
  final Record content;
  final int id;
  const RecordWidget(this.content, this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    double maxWidth;
    if (height > width) {
      maxWidth = width / 2 - MEDIUM_MARGIN * 5;
    } else {
      final cardsCount = width * 2 ~/ height;
      maxWidth = width / cardsCount - MEDIUM_MARGIN * (cardsCount * 2 + 1);
    }

    return GestureDetector(
      onTap: () => context.delegate.showRecordViewDialog(context, content.title, id),
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          margin: const EdgeInsets.all(LARGE_MARGIN),
          constraints: BoxConstraints(maxWidth: maxWidth > MIN_RECORD_WIDTH ? maxWidth : double.infinity, minHeight: MIN_RECORD_HEIGHT),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content.title),
              if (content.note.isNotEmpty) Text(content.note),
              for (var entry in content.entries) EntryWidget(entry),
            ],
          ),
        ),
      ),
    );
  }
}
