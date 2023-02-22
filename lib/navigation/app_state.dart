// ignore_for_file: constant_identifier_names

enum Rout {
  INITIAL(['/']),
  DATASET(['/records']),
  VIEW_RECORD(['/view']),
  EDIT_RECORD(['/add', '/edit']),
  UNKNOWN(['/unknown']);

  final List<String> prefixes;
  const Rout(this.prefixes);
}

class HoneState {
  final Rout rout;
  final Uri uri;
  final int? id;

  HoneState.initial()
      : rout = Rout.INITIAL,
        uri = Uri(path: "/"),
        id = null;

  HoneState.dataset()
      : rout = Rout.DATASET,
        uri = Uri(path: "/records"),
        id = null;

  HoneState.recordView(this.id)
      : rout = Rout.VIEW_RECORD,
        uri = Uri(path: "/view/$id");

  HoneState.recordEdit(this.id)
      : rout = Rout.EDIT_RECORD,
        uri = Uri(path: id == null ? "/add" : "/edit/$id");

  HoneState.unknown()
      : rout = Rout.UNKNOWN,
        uri = Uri(path: "/unknown"),
        id = null;
}
