import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/bloc.dart';
import 'package:honestorage/blocs/event.dart';
import 'package:honestorage/blocs/state.dart';
import 'package:honestorage/formats/bank_card.dart';
import 'package:honestorage/formats/email_address.dart';
import 'package:honestorage/formats/multiline_text.dart';
import 'package:honestorage/formats/password.dart';
import 'package:honestorage/formats/phone_number.dart';
import 'package:honestorage/formats/plain_text.dart';
import 'package:honestorage/models/entry.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/widgets/dataset.dart';

class HogWeedGo extends StatelessWidget {
  static const String title = 'HoneStorage';

  const HogWeedGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<DatasetBloc, DatasetState>(
        buildWhen: (previous, current) => previous.name != current.name,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("$title: ${state.name}"),
          ),
          body: const DatasetWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
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
                  ]);
              context.read<DatasetBloc>().add(RecordAdded(rec));
            },
            tooltip: "Add a report",
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
