import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:honestorage/blocs/record/bloc.dart';
import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/widgets/entry.dart';

Function _deepEq = const DeepCollectionEquality().equals;

class RecordEditPage extends StatelessWidget {
  RecordEditPage(int id) : super(key: ValueKey('RecordEditPageId$id'));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TitleInput(),
        const SizedBox(height: SMALL_MARGIN),
        _NoteInput(),
        const SizedBox(height: SMALL_MARGIN),
        _EntriesInput(),
      ],
    );
  }
}

class _TitleInput extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _titleController.text = context.read<RecordBloc>().state.title.value;
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) => TextField(
        maxLines: 3,
        controller: _titleController,
        key: const Key('recordForm_titleInput_textField'),
        onChanged: (title) => context.read<RecordBloc>().add(RecordTitleChanged(title)),
        decoration: InputDecoration(
          hintText: "What's the record name?",
          errorText: state.title.invalid ? 'Invalid title name' : null,
        ),
      ),
    );
  }
}

class _NoteInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => previous.note != current.note,
      builder: (context, state) => MarkdownTextInput(
        (note) => context.read<RecordBloc>().add(RecordNoteChanged(note)),
        state.note.value,
        maxLines: 10,
        actions: MarkdownType.values,
        insertLinksByDialog: false,
      ),
    );
  }
}

class _EntriesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => _deepEq(previous.entries, current.entries),
      builder: (context, state) => Column(
        children: [
          for (var entry in state.entries) EntryRecordEditWidget(entry.value),
        ],
      ),
    );
  }
}
