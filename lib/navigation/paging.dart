import 'package:flutter/material.dart';

void showRecordDialog(BuildContext context, String name, Widget dialog, Widget Function(BuildContext context)? action) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      if (width > height) {
        return _makeDialog(context, name, width / 2, height / 2, dialog, action);
      } else {
        return _makePage(context, name, dialog, action);
      }
    },
  );
}

Widget _makeDialog(BuildContext context, String name, double width, double height, Widget content, Widget Function(BuildContext context)? builder) {
  return Scaffold(
    backgroundColor: Theme.of(context).shadowColor.withAlpha(25),
    body: Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: content,
        ),
      ),
    ),
  );
}

Widget _makePage(BuildContext context, String name, Widget content, Widget Function(BuildContext context)? builder) {
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      actions: [if (builder != null) builder.call(context)],
    ),
    body: content,
  );
}
