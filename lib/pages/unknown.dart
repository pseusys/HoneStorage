import 'package:flutter/material.dart';

class UnknownWidget extends StatefulWidget {
  static const String title = 'HoneStorage: Routing error!';
  static const value = ValueKey('UnknownPage');
  const UnknownWidget() : super(key: value);

  @override
  State<UnknownWidget> createState() => _UnknownWidgetState();
}

class _UnknownWidgetState extends State<UnknownWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UnknownWidget.title),
      ),
      body: Column(),
    );
  }
}
