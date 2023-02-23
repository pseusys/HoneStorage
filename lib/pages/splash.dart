import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const value = ValueKey('SplashPage');
  const SplashPage() : super(key: value);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.hive,
          color: Colors.amber,
          size: 64.0,
        ),
      ),
    );
  }
}
