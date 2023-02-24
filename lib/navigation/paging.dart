import 'package:flutter/material.dart';

void showRecordDialog(BuildContext context, String name, Widget dialog, bool showBarrier, Widget Function(BuildContext context)? action) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  showGeneralDialog(
    context: context,
    barrierColor: showBarrier ? Colors.black54 : Colors.transparent,
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
    body: Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              AppBar(
                title: Text(name),
                actions: [if (builder != null) builder.call(context)],
              ),
              content,
            ],
          ),
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
