import 'package:flutter/material.dart';

class RecordEditPage extends StatelessWidget {
  static const route = "/record_view";

  final int id;
  RecordEditPage(this.id) : super(key: ValueKey('RecordEditPageId$id'));
  ValueKey get value => key as ValueKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('This is a nice overlay $id'),
      ],
    );
  }
}
