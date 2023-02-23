import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import 'package:honestorage/models/record.dart';
import 'package:honestorage/misc/constants.dart';
import 'package:honestorage/widgets/record.dart';

import 'package:honestorage/formats/bank_card.dart';
import 'package:honestorage/formats/email_address.dart';
import 'package:honestorage/formats/multiline_text.dart';
import 'package:honestorage/formats/password.dart';
import 'package:honestorage/formats/phone_number.dart';
import 'package:honestorage/formats/plain_text.dart';
import 'package:honestorage/models/entry.dart';

final rec = Record(
  "New Record",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  [
    Entry("Password", "098765", PasswordFormat()),
    Entry("Phone number", "1234567890", PhoneNumberFormat()),
    Entry("Plain text", "some text", PlainTextFormat()),
    Entry("Bank card", "1234567812345678", BankCardFormat()),
    Entry("Multiline text", "123456\n123456\n123456", MultilineTextFormat()),
    Entry("Email address", "as-rt.23@ret4.rt", EmailAddressFormat()),
  ],
);

class StorageWidget extends StatefulWidget {
  final List<Record> records;
  const StorageWidget(this.records, {Key? key}) : super(key: key);

  @override
  State<StorageWidget> createState() => _StorageWidgetState();
}

class _StorageWidgetState extends State<StorageWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: ReorderableWrap(
            spacing: MEDIUM_MARGIN,
            runSpacing: MEDIUM_MARGIN,
            alignment: WrapAlignment.spaceEvenly,
            padding: const EdgeInsets.all(MEDIUM_MARGIN),
            onReorder: (o, n) => setState(() => widget.records.insert(n, widget.records.removeAt(o))),
            children: [for (var record in widget.records) RecordWidget(record)],
          ),
        ),
      ],
    );
  }
}