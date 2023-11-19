import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._();

  static const bool defaultDarkMode = false;
  static const Color defaultColor = Colors.blue;
  static const String defaultApiHost = "localhost";

  static bool darkMode = defaultDarkMode;
  static Color color = defaultColor;
  static String apiHost = defaultApiHost;

  static List<String> searchHistory = [];

  static ColorScheme getColorScheme() {
    return darkMode
        ? ColorScheme.dark(primary: color)
        : ColorScheme.light(primary: color);
  }

  static void loadPreferences(SharedPreferences preferences) {
    darkMode = preferences.getBool("darkMode") ?? defaultDarkMode;
    color = Color(preferences.getInt("color") ?? defaultColor.value);
    apiHost = preferences.getString("apiHost") ?? defaultApiHost;
    searchHistory = preferences.getStringList("searchHistory") ?? [];
  }

  static void addSearchHistory(String searchTerm) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    searchHistory.add(searchTerm);
    preferences.setStringList("searchHistory", searchHistory);
  }

  static void clearSearchHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    searchHistory.clear();
    preferences.setStringList("searchHistory", searchHistory);
  }
}
