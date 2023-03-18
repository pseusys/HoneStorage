import 'package:honestorage/blocs/entry/form.dart';
import 'package:honestorage/formats/format.dart';

abstract class EntryEvent {
  const EntryEvent();
}

class NameChanged extends EntryEvent {
  final NameForm name;
  const NameChanged(this.name);
  factory NameChanged.raw(String name) => NameChanged(NameForm.dirty(name));
}

class FormatChanged extends EntryEvent {
  final Format format;
  const FormatChanged(this.format);
}

class DataChanged extends EntryEvent {
  final String data;
  const DataChanged(this.data);
}
