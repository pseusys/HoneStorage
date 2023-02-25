import 'package:flutter/material.dart';

import 'package:honestorage/models/record.dart';

class RecordEditPage extends StatelessWidget {
  final int id;
  final Record content;
  RecordEditPage(this.id, this.content) : super(key: ValueKey('RecordEditPageId$id'));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('This is a nice overlay $id'),
      ],
    );
  }
}
