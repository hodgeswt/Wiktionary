import 'package:flutter/material.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/constants/settings.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/datamodel/definition.dart';
import 'package:wiktionary/datamodel/result_data.dart';
import 'package:wiktionary/datamodel/results.dart';
import 'package:wiktionary/widgets/searchable_text_field.dart';
import 'package:wiktionary/widgets/section.dart';

class DefinitionData {
  static Widget definitionsBuilder(
      BuildContext context, Results? results, String word) {
    if (results == null || results.results.isEmpty) {
      return const SingleChildScrollView(
          child: SelectableText(Strings.noResults));
    }

    List<ResultData> data = results.results;

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return buildDefinition(data[index], index, word);
      },
    );
  }

  static Section buildDefinition(ResultData data, int index, String word) {
    List<Widget> widgets = [];

    if (data.etymology.isNotEmpty) {
      widgets.add(Section(
        content: <Widget>[SearchableText(text: data.etymology)],
        title: Strings.etymologyHeader,
        initiallyExpanded: false,
      ));
    }

    widgets.insertAll(
      widgets.length,
      buildDefinitionTexts(data.definitions),
    );

    return Section(
      title: "${index + 1}. $word",
      content: widgets,
      dividerColor: Settings.darkMode ? Colors.white : Colors.black,
    );
  }

  static List<Widget> buildDefinitionTexts(List<Definition> definitions) {
    List<Widget> widgets = [];
    for (Definition definition in definitions) {
      List<Widget> definitions = [];
      int i = 1;
      for (String definitionText in definition.text) {
        Section texts = Section(
          title: '${i++}',
          content: <Widget>[SearchableText(text: definitionText)],
          initiallyExpanded: false,
          horizontalPadding: Numbers.definitionTextHorizontalPadding,
          verticalPadding: Numbers.definitionTextVerticalPadding,
        );

        definitions.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              texts,
            ],
          ),
        );
      }

      widgets.add(
        Section(
          title: definition.partOfSpeech,
          content: definitions,
          initiallyExpanded: false,
          horizontalPadding: Numbers.definitionTextHorizontalPadding,
          verticalPadding: Numbers.definitionTextVerticalPadding,
        ),
      );
    }

    return widgets;
  }
}
