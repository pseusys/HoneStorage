const _topBoder = r"_";
const _bottomBoder = r"-";
const _singleLineSideBorder = r"<>";
const _topSideBorder = r"/\";
const _middleSideBorder = r"||";
const _bottomSideBorder = r"\/";

String createMessage(String message, {String actor = "🐝"}) {
  if (message.isEmpty) return "...";

  final lines = message.split('\n');
  final maxLength = lines.fold(0, (previous, element) => previous > element.length ? previous : element.length);

  String body = " ${List.filled(maxLength + 2, _topBoder).join()} \n";
  if (lines.length == 1) {
    body += "${_singleLineSideBorder[0]} ${lines[0]} ${_singleLineSideBorder[1]}\n";
  } else {
    body += "${_topSideBorder[0]} ${lines[0]} ${_topSideBorder[1]}\n";
    for (var i = 1; i < lines.length - 1; i++) {
      body += "${_middleSideBorder[0]} ${lines[i]} ${_middleSideBorder[1]}\n";
    }
    body += "${_bottomSideBorder[0]} ${lines[lines.length - 1]} ${_bottomSideBorder[1]}\n";
  }
  body += " ${List.filled(maxLength + 2, _bottomBoder).join()} \n";

  final actorOffset = maxLength * 2 ~/ 10 + 1;
  body += " ${List.filled(actorOffset, ' ').join()}\\n";
  body += " ${List.filled(actorOffset + 1, ' ').join()}\\n";
  body += " ${List.filled(actorOffset + 2, ' ').join()}$actor";
  return body;
}
