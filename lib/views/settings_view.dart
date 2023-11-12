import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiktionary/constants/settings.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/widgets/rebuilder.dart';
import 'package:wiktionary/widgets/section.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.title});

  final String title;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late Future<SharedPreferences> _prefs;

  bool _lightModeState = !Settings.darkMode;
  late MaterialStateProperty<Icon?> lightModeIcon;

  Color _colorState = Settings.color;

  bool _loadedPreferences = false;

  void _changeColor(Color color) {
    setState(() {
      _colorState = color;
    });
  }

  void _showColorPicker(SharedPreferences prefs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Strings.colorText),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _colorState,
              onColorChanged: _changeColor,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(Strings.cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(Strings.okButton),
              onPressed: () {
                Settings.color = _colorState;
                prefs.setInt("color", Settings.color.value);
                Navigator.of(context).pop();
                Rebuilder.of(context).rebuild();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadPreferences(SharedPreferences prefs) {
    if (_loadedPreferences) {
      return;
    }

    Settings.darkMode = prefs.getBool("darkMode") ?? Settings.defaultDarkMode;
    Settings.color =
        Color(prefs.getInt("color") ?? Settings.defaultColor.value);

    setState(() {
      _lightModeState = !Settings.darkMode;
    });

    setState(() {
      _colorState = Settings.color;
    });

    setState(() {
      _loadedPreferences = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    lightModeIcon =
        MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
      Color color = Theme.of(context).colorScheme.primary;
      if (states.contains(MaterialState.hovered)) {
        color = Settings.darkMode ? Colors.black : Colors.white;
      }
      if (!states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode_sharp);
      }
      return Icon(Icons.light_mode_sharp, color: color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<SharedPreferences?>(
        future: _prefs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadPreferences(snapshot.data!);
            });

            return Section(
              title: Strings.appearanceTitle,
              content: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: SwitchListTile(
                        thumbIcon: lightModeIcon,
                        title: const Text(Strings.lightModeText),
                        value: _lightModeState,
                        onChanged: (bool val) {
                          Settings.darkMode = !val;
                          snapshot.data!.setBool("darkMode", Settings.darkMode);
                          setState(
                            () {
                              _lightModeState = val;
                            },
                          );

                          Rebuilder.of(context).rebuild();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text(Strings.colorText),
                        trailing: FloatingActionButton(
                          backgroundColor: _colorState,
                          onPressed: () {
                            _showColorPicker(snapshot.data!);
                          },
                          shape: const CircleBorder(),
                        ),
                        onTap: () {
                          _showColorPicker(snapshot.data!);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: LinearProgressIndicator());
        },
      ),
    );
  }
}
