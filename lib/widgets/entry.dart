import 'package:flutter/material.dart';

import 'package:honestorage/models/entry.dart';

const _boldFont = TextStyle(fontWeight: FontWeight.bold);

class EntryStorageWidget extends StatelessWidget {
  final Entry content;

  const EntryStorageWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name, style: _boldFont),
        Text(content.private),
      ],
    );
  }
}

class EntryRecordViewWidget extends StatelessWidget {
  final Entry content;

  const EntryRecordViewWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name, style: _boldFont),
        Text(content.protected),
      ],
    );
  }
}

class EntryRecordEditWidget extends StatelessWidget {
  final Entry content;

  const EntryRecordEditWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name, style: _boldFont),
        Text(content.protected),
      ],
    );
  }
}
