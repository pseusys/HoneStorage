import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/models/entry.dart';

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
  final EntryForm entry;
  const RecordEntryAdded(this.entry);
  factory RecordEntryAdded.raw(Entry entry) => RecordEntryAdded(EntryForm.dirty(entry));
}

class RecordEntryChanged extends RecordEvent {
  final int index;
  final EntryForm entry;
  const RecordEntryChanged(this.index, this.entry);
  factory RecordEntryChanged.raw(int index, Entry entry) => RecordEntryChanged(index, EntryForm.dirty(entry));
}

class RecordEntryRemoved extends RecordEvent {
  final int index;
  const RecordEntryRemoved(this.index);
}

class RecordSubmitted extends RecordEvent {
  const RecordSubmitted();
}
