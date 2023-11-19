import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/storage.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/results_view.dart';
import 'package:wiktionary/widgets/history_list.dart';
import 'package:wiktionary/widgets/rebuilder.dart';
import 'package:wiktionary/widgets/section.dart';
import 'package:wiktionary/widgets/text_setting.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key, required this.title});

  final String title;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late Future<SharedPreferences> _futurePrefs;

  bool _loadedPreferences = false;

  void _loadPreferences(SharedPreferences prefs) {
    if (_loadedPreferences) {
      return;
    }

    Storage.loadPreferences(prefs);

    setState(() {
      _loadedPreferences = true;
    });
  }

  void _clearSearchHistory() {
    Storage.clearSearchHistory();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _futurePrefs = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: HistoryList.getHistoryList(),
          ),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildClearButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Numbers.defaultHorizontalPadding,
            vertical: Numbers.defaultVerticalPadding,
          ),
          child: FilledButton(
            onPressed: _clearSearchHistory,
            child: const Text(Strings.clearSearchHistory),
          ),
        ),
      ],
    );
  }
}
