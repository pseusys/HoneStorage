// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const SMALL_MARGIN = 5.0;
const MEDIUM_MARGIN = 10.0;
const LARGE_MARGIN = 15.0;

const MIN_RECORD_WIDTH = 150.0;
const MIN_RECORD_HEIGHT = 25.0;

final theme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],

  // Define the default font family.
  fontFamily: 'Georgia',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);
