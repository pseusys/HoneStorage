import 'package:flutter/material.dart';

import 'package:honestorage/misc/cowsay.dart';

class UnknownPage extends StatelessWidget {
  static const title = 'HoneStorage: Routing error!';
  static const value = ValueKey('UnknownPage');
  const UnknownPage() : super(key: value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UnknownPage.title),
      ),
      body: Center(
        child: Text(createMessage("Bzzzz... Nothing to find here...")),
      ),
    );
  }
}
