import 'package:flutter/material.dart';

class RecordEditPage extends StatelessWidget {
  static const route = "/record_view";

  final int id;
  RecordEditPage(this.id) : super(key: ValueKey('RecordViewPageId$id'));
  ValueKey get value => key as ValueKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'This is a nice overlay $id',
          style: const TextStyle(color: Colors.black, fontSize: 30.0),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Dismiss'),
        )
      ],
    );
  }
}
