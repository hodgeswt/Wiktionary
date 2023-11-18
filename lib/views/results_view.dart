import 'package:flutter/material.dart';
import 'package:wiktionary/datamodel/results.dart';
import 'package:wiktionary/widgets/definition_data.dart';
import 'package:wiktionary/api/dio_client.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key, required this.searchTerm});

  final String searchTerm;

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  final DioClient _client = DioClient();

  late Future<Results?> _result;

  @override
  void initState() {
    super.initState();
    _result = getDefinition();
  }

  Future<Results?> getDefinition() async {
    return _client.getDefinition("english", widget.searchTerm.trim());
  }

  @override
  Widget build(BuildContext context) {
    // Make a call to the API and display the wikitext result if it exists,
    // and make it all scrollable so that it doesn't clip off the bottom
    // of the screen

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchTerm),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: FutureBuilder<Results?>(
          future: _result,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DefinitionData.definitionsBuilder(
                  context, snapshot.data, widget.searchTerm);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: LinearProgressIndicator());
          },
        ),
      ),
    );
  }
}
