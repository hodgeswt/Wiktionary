import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiktionary/constants/settings.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/main_view.dart';
import 'package:wiktionary/widgets/rebuilder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<SharedPreferences> _prefs;

  void _loadPreferences(SharedPreferences prefs) {
    Settings.darkMode = prefs.getBool("darkMode") ?? Settings.defaultDarkMode;
    Settings.color =
        Color(prefs.getInt("color") ?? Settings.defaultColor.value);
  }

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Rebuilder(
      builder: (context) {
        return FutureBuilder<SharedPreferences?>(
          future: _prefs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _loadPreferences(snapshot.data!);
            }

            return MaterialApp(
              title: 'Wiktionary',
              theme: ThemeData(
                  useMaterial3: true, colorScheme: Settings.getColorScheme()),
              home: const MainView(title: Strings.title),
            );
          },
        );
      },
    );
  }
}
