import 'package:flutter/material.dart';

import 'package:honestorage/honestorage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    String key = "Peculiar machines";
    String encrypted = encrypt(text, key);
    String text_sign = sign(text);
    String decrypted = decrypt(encrypted, key);
    String decr_sign = sign(decrypted);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$text: ${text.length}"),
            Text(key),
            Text(
              'Encrypted: $encrypted: ${encrypted.length}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Decrypted: $decrypted: ${decrypted.length}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Sign: ${text_sign == decr_sign}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
