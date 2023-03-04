import 'package:formz/formz.dart';
import 'package:honestorage/formats/plain_text.dart';

import 'package:honestorage/models/format.dart';

enum NameValidationError { empty }

class NameForm extends FormzInput<String, NameValidationError> {
  const NameForm.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

enum DataValidationError { invalid }

class DataForm extends FormzInput<String, DataValidationError> {
  final Format _format;

  const DataForm.pure()
      : _format = const PlainTextFormat(),
        super.pure('');
  DataForm.dirty(this._format, [String value = '']) : super.dirty(value);

  @override
  DataValidationError? validator(String? value) {
    return value != null && _format.check(value) ? null : DataValidationError.invalid;
  }
}
