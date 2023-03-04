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

enum EntriesValidationError { empty, invalid }

class EntriesForm extends FormzInput<List<EntryState>, EntriesValidationError> {
  EntriesForm.dirty(List<EntryState> value) : super.dirty(value);

  @override
  EntriesValidationError? validator(List<EntryState>? value) {
    return value?.any((element) => element.status != FormzStatus.valid) == true ? EntriesValidationError.invalid : null;
  }
}
