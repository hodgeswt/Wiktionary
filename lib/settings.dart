import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  Settings._();

  static const bool defaultDarkMode = false;
  static const Color defaultColor = Colors.blue;
  static const String defaultApiHost = "localhost";
  static const String defaultApiPort = "8671";

  static bool darkMode = defaultDarkMode;
  static Color color = defaultColor;
  static String apiHost = defaultApiHost;
  static String apiPort = defaultApiPort;

  static ColorScheme getColorScheme() {
    return darkMode
        ? ColorScheme.dark(primary: color)
        : ColorScheme.light(primary: color);
  }

  static void loadPreferences(SharedPreferences preferences) {
    darkMode = preferences.getBool("darkMode") ?? defaultDarkMode;
    color = Color(preferences.getInt("color") ?? defaultColor.value);
    apiHost = preferences.getString("apiHost") ?? defaultApiHost;
    apiPort = preferences.getString("apiPort") ?? defaultApiPort;
  }
}
