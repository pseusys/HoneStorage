import 'package:honestorage/models/entry.dart';

abstract class RecordEvent {
  const RecordEvent();
}

class RecordTitleChanged extends RecordEvent {
  final String title;
  const RecordTitleChanged(this.title);
}

class RecordNoteChanged extends RecordEvent {
  final String note;
  const RecordNoteChanged(this.note);
}

class RecordEntriesChanged extends RecordEvent {
  final List<Entry> entries;
  const RecordEntriesChanged(this.entries);
}

class RecordSubmitted extends RecordEvent {
  const RecordSubmitted();
}
