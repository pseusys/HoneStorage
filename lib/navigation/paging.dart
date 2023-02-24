import 'package:flutter/material.dart';

void showRecordDialog(BuildContext context, String name, Widget dialog, bool showBarrier, List<IconButton>? actions) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  showGeneralDialog(
    context: context,
    barrierColor: showBarrier ? Colors.black54 : Colors.transparent,
    pageBuilder: (context, animation, secondaryAnimation) {
      if (width > height) {
        return _makeDialog(context, name, width / 2, height / 2, dialog, actions);
      } else {
        return _makePage(context, name, dialog, actions);
      }
    },
  );
}

Widget _makeDialog(BuildContext context, String name, double width, double height, Widget content, List<IconButton>? actions) {
  return Scaffold(
    backgroundColor: Colors.transparent,
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
                actions: [if (actions != null) ...actions],
              ),
              content,
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _makePage(BuildContext context, String name, Widget content, List<IconButton>? actions) {
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      actions: [if (actions != null) ...actions],
    ),
    body: content,
  );
}
