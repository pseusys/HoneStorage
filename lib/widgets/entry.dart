import 'package:flutter/material.dart';

import 'package:honestorage/models/entry.dart';

class EntryWidget extends StatelessWidget {
  final Entry content;

  const EntryWidget(this.content, {Key? key}) : super(key: key);

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
