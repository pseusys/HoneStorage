import 'package:formz/formz.dart';
import 'package:honestorage/blocs/entry/state.dart';

enum TitleValidationError { empty }

class TitleForm extends FormzInput<String, TitleValidationError> {
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

enum EntriesValidationError { empty, invalid }

class EntriesForm extends FormzInput<List<EntryState>, EntriesValidationError> {
  EntriesForm.dirty(List<EntryState> value) : super.dirty(value);

  @override
  EntriesValidationError? validator(List<EntryState>? value) {
    if (value?.isEmpty == true) return EntriesValidationError.empty;
    if (value?.any((element) => element.status != FormzStatus.valid) == true) return EntriesValidationError.invalid;
    return null;
  }
}
