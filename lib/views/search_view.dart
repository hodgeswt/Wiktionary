import 'package:flutter/material.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/results_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.title});

  final String title;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _controller;

  String _searchTerm = Strings.empty;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _updateSearchTerm(String newValue) {
    setState(() {
      _searchTerm = newValue;
    });
  }

  Future<void> _textFieldSubmitted(String newValue) async {
    _resultsViewTransition();
  }

  void _resultsViewTransition() {
    if (_searchTerm.isEmpty) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsView(
          searchTerm: ResultsView.cleanSearchTerm(_searchTerm),
        ),
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Numbers.defaultHorizontalPadding,
            vertical: Numbers.defaultVerticalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: Strings.wordSearchHint,
                  ),
                  onChanged: _updateSearchTerm,
                  onSubmitted: _textFieldSubmitted,
                  autofocus: true,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: _resultsViewTransition,
                  icon: const Icon(Icons.search),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
