import 'package:flutter/material.dart';
import 'package:wiktionary/storage.dart';

class DynamicTheme {
  const DynamicTheme._();

  static Color dividerColor = Storage.darkMode ? Colors.white : Colors.black;
}
