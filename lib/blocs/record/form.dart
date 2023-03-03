import 'package:formz/formz.dart';
import 'package:honestorage/models/entry.dart';

enum TitleValidationError { empty }

class TitleForm extends FormzInput<String, TitleValidationError> {
  const TitleForm.pure() : super.pure('');
  const TitleForm.dirty([String value = '']) : super.dirty(value);

  @override
  TitleValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TitleValidationError.empty;
  }
}

enum NoteValidationError { never }

class NoteForm extends FormzInput<String, NoteValidationError> {
  const NoteForm.pure() : super.pure('');
  const NoteForm.dirty([String value = '']) : super.dirty(value);

  @override
  NoteValidationError? validator(String? value) => null;
}

enum EntriesValidationError { empty }

class EntriesForm extends FormzInput<List<EntryForm>, EntriesValidationError> {
  EntriesForm.dirty(List<EntryForm> value) : super.dirty(value);

  @override
  EntriesValidationError? validator(List<EntryForm>? value) {
    return value?.isNotEmpty == true ? null : EntriesValidationError.empty;
  }
}

enum EntryValidationError { nameEmpty, dataInvalid }

class EntryForm extends FormzInput<Entry, EntryValidationError> {
  EntryForm.dirty([Entry? value]) : super.dirty(value ?? Entry.create());

  @override
  EntryValidationError? validator(Entry? value) {
    if (value?.name.isNotEmpty != true) return EntryValidationError.nameEmpty;
    if (value?.check != true) return EntryValidationError.dataInvalid;
    return null;
  }
}
