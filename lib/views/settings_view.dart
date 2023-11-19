import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/link.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/storage.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/widgets/rebuilder.dart';
import 'package:wiktionary/widgets/section.dart';
import 'package:wiktionary/widgets/text_setting.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.title});

  final String title;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late Future<SharedPreferences> _futurePrefs;
  late SharedPreferences _prefs;

  bool _lightModeState = !Storage.darkMode;
  late MaterialStateProperty<Icon?> lightModeIcon;

  Color _colorState = Storage.color;

  String _apiHost = Storage.apiHost;
  late TextEditingController _apiHostController;
  String _savedApiHost = Storage.apiHost;
  bool _apiHostModified = false;

  bool _loadedPreferences = false;

  void _updateColor(Color color) {
    setState(() {
      _colorState = color;
    });
  }

  void _updateApiHost(String newValue) {
    bool modified = newValue != _savedApiHost;
    setState(() {
      _apiHostModified = modified;
      _apiHost = newValue;
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
              onColorChanged: _updateColor,
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
                Storage.color = _colorState;
                prefs.setInt("color", Storage.color.value);
                Navigator.of(context).pop();
                Rebuilder.of(context).rebuild();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveConnectionPreferences() {
    _prefs.setString("apiHost", _apiHost);

    Storage.apiHost = _apiHost;

    setState(() {
      _apiHostModified = false;
      _savedApiHost = _apiHost;
    });
  }

  void _loadPreferences(SharedPreferences prefs) {
    if (_loadedPreferences) {
      return;
    }

    _prefs = prefs;

    Storage.loadPreferences(prefs);

    setState(() {
      _lightModeState = !Storage.darkMode;
      _colorState = Storage.color;
      _apiHost = Storage.apiHost;
    });

    setState(() {
      _loadedPreferences = true;
    });
  }

  String? _apiHostFieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return Strings.nonNullFieldError;
    }

    return _apiHostModified ? Strings.unsavedFieldError : null;
  }

  @override
  void initState() {
    super.initState();

    _apiHostController = TextEditingController(text: _apiHost);

    _futurePrefs = SharedPreferences.getInstance();

    lightModeIcon =
        MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
      Color color = Theme.of(context).colorScheme.primary;
      if (states.contains(MaterialState.hovered)) {
        color = Storage.darkMode ? Colors.black : Colors.white;
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
        future: _futurePrefs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadPreferences(snapshot.data!);
            });

            return _buildSettingsView(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: LinearProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSettingsView(SharedPreferences prefs) {
    return ListView(
      children: <Widget>[
        _buildAppearanceSection(prefs),
        _buildConnectionSection(prefs),
        Column(
          children: <Widget>[
            const Text(Strings.license),
            const Text(Strings.attribution),
            Link(
              uri: Uri.parse(Strings.licenseLink),
              builder: (context, followLink) {
                return TextButton(
                  onPressed: followLink,
                  child: const Text(Strings.licenseLinkText),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppearanceSection(SharedPreferences prefs) {
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
                  Storage.darkMode = !val;
                  prefs.setBool("darkMode", Storage.darkMode);
                  setState(() {
                    _lightModeState = val;
                  });

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
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Numbers.defaultHorizontalPadding,
                    vertical: Numbers.defaultVerticalPadding,
                  ),
                  child: FloatingActionButton(
                    backgroundColor: _colorState,
                    onPressed: () {
                      _showColorPicker(prefs);
                    },
                    shape: const CircleBorder(),
                  ),
                ),
                onTap: () {
                  _showColorPicker(prefs);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConnectionSection(SharedPreferences prefs) {
    return Section(
      initiallyExpanded: false,
      title: Strings.connectionTitle,
      content: <Widget>[
        TextSetting(
          labelText: Strings.apiHostLabel,
          controller: _apiHostController,
          onChanged: _updateApiHost,
          validator: _apiHostFieldValidator,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Numbers.defaultHorizontalPadding,
                vertical: Numbers.defaultVerticalPadding,
              ),
              child: FilledButton(
                onPressed: _saveConnectionPreferences,
                child: const Text(Strings.saveConnectionButton),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
