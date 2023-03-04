import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/entry/bloc.dart';
import 'package:honestorage/blocs/entry/state.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:honestorage/models/entry.dart';
import 'package:honestorage/blocs/record/bloc.dart';
import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/widgets/entry.dart';

class RecordEditPage extends StatelessWidget {
  RecordEditPage(int? id) : super(key: ValueKey(id == null ? 'RecordAddPage' : 'RecordEditPageId$id'));

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
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
      builder: (context, state) => Column(
        children: [
          TextField(
            maxLines: 3,
            controller: _titleController,
            key: const Key('recordForm_titleInput_textField'),
            onChanged: (title) => context.read<RecordBloc>().add(RecordTitleChanged.raw(title)),
            decoration: InputDecoration(
              hintText: "What's the record name?",
              errorText: state.title.invalid ? 'Invalid title name' : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => previous.note != current.note,
      builder: (context, state) => Column(
        children: [
          MarkdownTextInput(
            (note) => context.read<RecordBloc>().add(RecordNoteChanged(note)),
            state.note,
            maxLines: 5,
            actions: MarkdownType.values,
            insertLinksByDialog: false,
          ),
        ],
      ),
    );
  }
}

class _EntriesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => previous.entries.length != current.entries.length,
      builder: (context, state) => Column(
        children: [
          for (var i = 0; i < state.entries.length; i++)
            BlocProvider<EntryBloc>(
              create: (context) => EntryBloc(i, context.read<RecordBloc>(), state.entries[i]),
              child: EntryRecordEditWidget(state.entries[i].name.value, state.entries[i].data.value),
            ),
          TextButton(
            onPressed: () => context.read<RecordBloc>().add(RecordEntryAdded(EntryState.copy(Entry.create()))),
            child: const Text("Add new entry..."),
          ),
        ],
      ),
    );
  }
}
