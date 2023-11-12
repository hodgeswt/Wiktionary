import 'package:flutter/material.dart';

class Settings {
  Settings._();

  static const bool defaultDarkMode = false;
  static const Color defaultColor = Colors.blue;

  static bool darkMode = defaultDarkMode;
  static Color color = defaultColor;

  static ColorScheme getColorScheme() {
    return darkMode
        ? ColorScheme.dark(primary: color)
        : ColorScheme.light(primary: color);
  }
}
