import 'package:formz/formz.dart';

import 'package:honestorage/blocs/entry/form.dart';
import 'package:honestorage/models/entry.dart';
import 'package:honestorage/models/format.dart';

class EntryState {
  final FormzStatus status;
  final NameForm name;
  final Format format;
  final DataForm data;

  const EntryState._(this.format, {this.status = FormzStatus.invalid, this.name = const NameForm.dirty(), this.data = const DataForm.pure()});
  factory EntryState.copy(Entry entry) =>
      EntryState._(entry.format, status: FormzStatus.pure, name: NameForm.dirty(entry.name), data: DataForm.dirty(entry.format, entry.data));

  Entry cast() => Entry(name.value, data.value, format);

  EntryState copyWith({FormzStatus? status, NameForm? name, Format? format, DataForm? data}) => EntryState._(
        format ?? this.format,
        status: status ?? this.status,
        name: name ?? this.name,
        data: data ?? this.data,
      );
}
