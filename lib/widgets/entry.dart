import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              onPressed: () async => await Clipboard.setData(ClipboardData(text: content)),
            ),
            TextButton(
              child: const Text("Continue"),
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  final Entry content;
  final Function(Entry entry)? onChanged;

  EntryRecordEditWidget(this.content, {this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nameController.text = content.name;
    _nameController.selection = TextSelection.collapsed(offset: _nameController.text.length);
    _dataController.text = content.data;
    _dataController.selection = TextSelection.collapsed(offset: _dataController.text.length);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: DropdownButton<String>(
            value: content.format.runtimeType.toString(),
            items: FORMATS.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value.description))).toList(),
            onChanged: (String? value) => onChanged?.call(content.copyWith(format: FORMATS[value]?.constructor.call())),
          ),
        ),
        Flexible(
          child: TextField(
            controller: _nameController,
            key: const Key('recordForm_entryInput_nameField'),
            style: _boldFont,
            onChanged: (name) => onChanged?.call(content.copyWith(name: name)),
            decoration: const InputDecoration(
              hintText: "Entry name",
            ),
          ),
        ),
        Flexible(
          child: TextField(
            controller: _dataController,
            key: const Key('recordForm_entryInput_dataField'),
            onChanged: (data) => onChanged?.call(content.copyWith(data: data)),
            decoration: const InputDecoration(
              hintText: "Entry data",
            ),
          ),
        ),
      ],
    );
  }
}
