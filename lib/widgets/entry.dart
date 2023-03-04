import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honestorage/blocs/entry/bloc.dart';
import 'package:honestorage/blocs/entry/event.dart';
import 'package:honestorage/blocs/entry/state.dart';

import 'package:honestorage/models/entry.dart';
import 'package:honestorage/models/format.dart';

const _boldFont = TextStyle(fontWeight: FontWeight.bold);

showAlertDialog(BuildContext context, String content) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              child: const Text("Copy to clipboard"),
              onPressed: () => Clipboard.setData(ClipboardData(text: content)).then((_) => Navigator.pop(context)),
            ),
            TextButton(
              child: const Text("Dismiss"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );

class EntryStorageWidget extends StatelessWidget {
  final Entry content;

  const EntryStorageWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name, style: _boldFont),
        Text(content.private),
      ],
    );
  }
}

class EntryRecordViewWidget extends StatelessWidget {
  final Entry content;

  const EntryRecordViewWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(content.name, style: _boldFont),
        Text(content.protected),
        if (content.protected != content.public)
          IconButton(
            onPressed: () => showAlertDialog(context, content.public),
            icon: const Icon(Icons.remove_red_eye),
          ),
        IconButton(
          onPressed: () async => await Clipboard.setData(ClipboardData(text: content.public)),
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }
}

class EntryRecordEditWidget extends StatelessWidget {
  final TextEditingController _nameController;
  final TextEditingController _dataController;

  EntryRecordEditWidget(String name, String data, {Key? key})
      : _nameController = TextEditingController(text: name),
        _dataController = TextEditingController(text: data),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: DropdownButton<Format>(
                  value: state.format,
                  items: FORMATS.entries.map((e) => DropdownMenuItem(value: e.value.format, child: Text(e.value.description))).toList(),
                  onChanged: (Format? value) {
                    if (value != null) context.read<EntryBloc>().add(FormatChanged(value));
                  },
                ),
              ),
              Flexible(
                child: TextField(
                  controller: _nameController,
                  key: const Key('recordForm_entryInput_nameField'),
                  onChanged: (name) => context.read<EntryBloc>().add(NameChanged.raw(name)),
                  decoration: InputDecoration(
                    hintText: "Entry name",
                    errorText: state.name.invalid ? 'Invalid entry name' : null,
                  ),
                ),
              ),
              Flexible(
                child: TextField(
                  controller: _dataController,
                  key: const Key('recordForm_entryInput_dataField'),
                  onChanged: (data) => context.read<EntryBloc>().add(DataChanged(data)),
                  decoration: InputDecoration(
                    hintText: "Entry data",
                    errorText: state.data.invalid ? 'Invalid entry data' : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
