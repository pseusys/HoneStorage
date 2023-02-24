import 'package:flutter/material.dart';

void showRecordDialog(BuildContext context, String name, Widget dialog, bool second, Widget Function(BuildContext ctx)? action) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      if (width > height) {
        return _makeDialog(context, name, width / 2, height / 2, second, dialog, action);
      } else {
        return _makePage(context, name, dialog, action);
      }
    },
  );
}

Widget _makeDialog(BuildContext context, String name, double w, double h, bool second, Widget content, Widget Function(BuildContext ctx)? builder) {
  return Scaffold(
    backgroundColor: second ? Colors.transparent : Theme.of(context).shadowColor.withAlpha(25),
    body: Center(
      child: SizedBox(
        width: w,
        height: h,
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

Widget _makePage(BuildContext context, String name, Widget content, Widget Function(BuildContext ctx)? builder) {
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      actions: [if (builder != null) builder.call(context)],
    ),
    body: content,
  );
}
