import 'package:flutter/material.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/storage.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/widgets/history_list.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key, required this.title});

  final String title;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  void _clearSearchHistory() {
    Storage.clearSearchHistory();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
