import 'dart:math';

import 'package:flutter/material.dart';

import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/widgets/entry.dart';

class RecordWidget extends StatelessWidget {
  final Record content;

  const RecordWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double halfHeight = height / 2;
    double maxWidth;
    if (height > width) {
      maxWidth = halfHeight - MEDIUM_MARGIN * 3;
    } else {
      int cardsCount = width ~/ halfHeight;
      maxWidth = width ~/ cardsCount - MEDIUM_MARGIN * (cardsCount + 1);
    }

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.all(SMALL_MARGIN),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(content.title),
            if (content.note.isNotEmpty) Text(content.note),
            for (var record in content.entries) EntryWidget(record),
          ],
        ),
      ),
    );
  }
}
