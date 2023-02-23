import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  static const String title = 'HoneStorage: Routing error!';
  static const value = ValueKey('UnknownPage');
  const UnknownPage() : super(key: value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UnknownPage.title),
      ),
      body: Column(),
    );
  }
}
