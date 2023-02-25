import 'package:flutter/material.dart';

import 'package:honestorage/models/entry.dart';

class EntryStorageWidget extends StatelessWidget {
  final Entry content;

  const EntryStorageWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name),
        Text(content.private),
      ],
    );
  }
}

class EntryRecordWidget extends StatelessWidget {
  final Entry content;

  const EntryRecordWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name),
        Text(content.protected),
      ],
    );
  }
}
