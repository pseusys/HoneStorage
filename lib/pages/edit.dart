import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:honestorage/blocs/record/form.dart';
import 'package:honestorage/blocs/record/bloc.dart';
import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/widgets/entry.dart';

bool entryFormListsEqual(List<EntryForm> list1, List<EntryForm> list2) {
  if (list1.length != list2.length) return false;
  for (var i = 0; i < list1.length; i++) {
    if (!list1[i].value.equals(list2[i].value)) return false;
  }
  return true;
}

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
            decoration: const InputDecoration(
              hintText: "What's the record name?",
            ),
          ),
          if (state.title.invalid) const Text('Invalid title name'),
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
            (note) => context.read<RecordBloc>().add(RecordNoteChanged.raw(note)),
            state.note.value,
            maxLines: 5,
            actions: MarkdownType.values,
            insertLinksByDialog: false,
          ),
          if (state.note.invalid) const Text('Invalid note text'),
        ],
      ),
    );
  }
}

class _EntriesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => !entryFormListsEqual(previous.entries, current.entries),
      builder: (context, state) => Column(
        children: [
          for (var i = 0; i < state.entries.length; i++)
            Column(
              children: [
                EntryRecordEditWidget(
                  state.entries[i].value,
                  onChanged: (entry) => context.read<RecordBloc>().add(RecordEntryChanged.raw(i, entry)),
                ),
                if (state.entries[i].invalid) const Text('Invalid record'),
              ],
            ),
          TextButton(
            onPressed: () => context.read<RecordBloc>().add(RecordEntryAdded(EntryForm.dirty())),
            child: const Text("Add new entry..."),
          ),
        ],
      ),
    );
  }
}
