import 'package:honestorage/blocs/entry/state.dart';
import 'package:honestorage/blocs/record/form.dart';

abstract class RecordEvent {
  const RecordEvent();
}

class RecordTitleChanged extends RecordEvent {
  final TitleForm title;
  const RecordTitleChanged(this.title);
  factory RecordTitleChanged.raw(String title) => RecordTitleChanged(TitleForm.dirty(title));
}

class RecordNoteChanged extends RecordEvent {
  final NoteForm note;
  const RecordNoteChanged(this.note);
  factory RecordNoteChanged.raw(String note) => RecordNoteChanged(NoteForm.dirty(note));
}

class RecordEntryAdded extends RecordEvent {
  final EntryState entry;
  const RecordEntryAdded(this.entry);
}

class RecordEntryChanged extends RecordEvent {
  final int index;
  final EntryState entry;
  const RecordEntryChanged(this.index, this.entry);
}

class RecordEntryRemoved extends RecordEvent {
  final int index;
  const RecordEntryRemoved(this.index);
}

class RecordSubmitted extends RecordEvent {
  const RecordSubmitted();
}
