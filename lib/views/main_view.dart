import 'package:flutter/material.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/search_view.dart';
import 'package:wiktionary/views/settings_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void _searchViewTransition() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchView(
          title: Strings.searchViewTitle,
        ),
      ),
    );
  }

  void _settingsViewTransition() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsView(
          title: Strings.settingsViewTitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _searchViewTransition,
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: _settingsViewTransition,
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Numbers.defaultHorizontalPadding,
                vertical: Numbers.defaultVerticalPadding,
              ),
              child: Text(
                Strings.welcomeText,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
