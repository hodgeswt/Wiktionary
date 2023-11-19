import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/results_view.dart';

class HistoryList {
  HistoryList._();

  static Widget getHistoryList({bool preventScroll = false}) {
    Future<SharedPreferences?> futurePrefs = SharedPreferences.getInstance();
    return FutureBuilder<SharedPreferences?>(
      future: futurePrefs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String>? history = snapshot.data!.getStringList("searchHistory");

          if (history == null || history.isEmpty) {
            return const ListTile(
              title: Card(
                child: ListTile(
                  title: Text(Strings.emptyHistory),
                ),
              ),
            );
          }
          return _buildHistoryList(
            history,
            preventScroll,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: LinearProgressIndicator());
      },
    );
  }

  static Widget _buildHistoryList(List<String> history, bool preventScroll) {
    history = history.reversed.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Numbers.defaultHorizontalPadding,
        vertical: Numbers.defaultVerticalPadding,
      ),
      physics: preventScroll ? const NeverScrollableScrollPhysics() : null,
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            shape: ContinuousRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Numbers.cornerRadius)),
            ),
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
          ),
        );
      },
    );
  }
}
