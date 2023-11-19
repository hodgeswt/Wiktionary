import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/results_view.dart';

class HistoryList {
  HistoryList._();

  static Widget getHistoryList() {
    Future<SharedPreferences?> _futurePrefs = SharedPreferences.getInstance();
    return FutureBuilder<SharedPreferences?>(
      future: _futurePrefs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildHistoryList(
            snapshot.data!.getStringList("searchHistory") ??
                [Strings.emptyHistory],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: LinearProgressIndicator());
      },
    );
  }

  static Widget _buildHistoryList(List<String> history) {
    history = history.reversed.toList();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: Numbers.defaultHorizontalPadding,
        vertical: Numbers.defaultVerticalPadding,
      ),
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Center(
            child: Text(history[index]),
          ),
          onTap: () {
            String searchTerm = history[index];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsView(
                  searchTerm: ResultsView.cleanSearchTerm(searchTerm),
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
