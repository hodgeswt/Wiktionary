import 'package:flutter/material.dart';
import 'package:wiktionary/settings.dart';

class DynamicTheme {
  const DynamicTheme._();

  static Color dividerColor = Settings.darkMode ? Colors.white : Colors.black;
}
