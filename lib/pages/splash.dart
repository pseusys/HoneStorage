import 'package:flutter/material.dart';

class SplashWidget extends StatefulWidget {
  static const value = ValueKey('SplashPage');
  const SplashWidget() : super(key: value);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
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
