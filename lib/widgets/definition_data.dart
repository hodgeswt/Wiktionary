import 'package:flutter/material.dart';
import 'package:wiktionary/constants/dynamic_theme.dart';
import 'package:wiktionary/constants/numbers.dart';
import 'package:wiktionary/constants/settings.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/datamodel/definition.dart';
import 'package:wiktionary/datamodel/pronunciations.dart';
import 'package:wiktionary/datamodel/related_words.dart';
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

    if (data.first.definitions.isEmpty) {
      return Card(child: ListTile(title: Text('${Strings.noResults} "$word"')));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildDefinition(data[index], index, word),
          ],
        );
      },
    );
  }

  static Section buildDefinition(ResultData data, int index, String word) {
    List<Widget> widgets = [];

    if (data.etymology.isNotEmpty) {
      widgets.add(Section(
        content: <Widget>[
          ListTile(title: SearchableText(text: data.etymology))
        ],
        title: Strings.etymologyHeader,
        initiallyExpanded: false,
      ));
    }

    if (data.pronunciations.text.isNotEmpty) {
      widgets.insertAll(
        widgets.length,
        _buildPronunciations(data.pronunciations),
      );
    }

    widgets.insertAll(
      widgets.length,
      _buildDefinitions(data.definitions),
    );

    return Section(
      title: "${index + 1}. $word",
      content: widgets,
      dividerColor: Settings.darkMode ? Colors.white : Colors.black,
    );
  }

  static List<Widget> _buildDefinitions(List<Definition> definitions) {
    List<Widget> widgets = [];
    for (Definition definition in definitions) {
      List<Widget> children = [];

      children.insertAll(
        children.length,
        _buildDefinitionTexts(definition.text),
      );

      if (definition.examples.isNotEmpty) {
        children.insertAll(
          children.length,
          _buildExamples(definition.examples),
        );
      }

      children.insertAll(
        children.length,
        _buildRelatedWords(definition.relatedWords),
      );

      widgets.add(
        Section(
          title: definition.partOfSpeech,
          content: children,
          initiallyExpanded: false,
          horizontalPadding: Numbers.definitionTextHorizontalPadding,
          verticalPadding: Numbers.definitionTextVerticalPadding,
        ),
      );
    }

    return widgets;
  }

  static List<Widget> _buildExamples(List<String> examples) {
    List<Widget> ret = [];
    List<Widget> children = [];

    for (String example in examples) {
      children.add(ListTile(title: SearchableText(text: example)));
    }

    Section section = Section(
      title: Strings.examplesHeader,
      content: children,
      initiallyExpanded: false,
      horizontalPadding: Numbers.definitionTextHorizontalPadding,
      verticalPadding: Numbers.definitionTextVerticalPadding,
      dividerColor: DynamicTheme.dividerColor,
    );

    ret.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          section,
        ],
      ),
    );

    return ret;
  }

  static List<Widget> _buildPronunciations(Pronunciations pronunciations) {
    List<Widget> ret = [];
    List<Widget> children = [];
    for (String pronunciation in pronunciations.text) {
      children.add(ListTile(title: SearchableText(text: pronunciation)));
    }

    Section section = Section(
      title: Strings.pronunciationHeader,
      content: children,
      initiallyExpanded: false,
      horizontalPadding: Numbers.definitionTextHorizontalPadding,
      verticalPadding: Numbers.definitionTextVerticalPadding,
      dividerColor: DynamicTheme.dividerColor,
    );

    ret.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          section,
        ],
      ),
    );

    return ret;
  }

  static List<Widget> _buildRelatedWords(List<RelatedWords> relatedWords) {
    List<Widget> ret = [];
    for (RelatedWords relatedWord in relatedWords) {
      List<Widget> relations = [];
      for (String relation in relatedWord.words) {
        relations.add(ListTile(title: SearchableText(text: relation)));
      }

      Section relatedWords = Section(
        title: relatedWord.relationshipType,
        content: relations,
        initiallyExpanded: false,
        horizontalPadding: Numbers.definitionTextHorizontalPadding,
        verticalPadding: Numbers.definitionTextVerticalPadding,
        dividerColor: DynamicTheme.dividerColor,
      );

      ret.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            relatedWords,
          ],
        ),
      );
    }

    return ret;
  }

  static List<Widget> _buildDefinitionTexts(List<String> definitionTexts) {
    List<Widget> ret = [];
    int i = 1;
    for (String definitionText in definitionTexts) {
      Section texts = Section(
        title: '${i++}',
        content: <Widget>[
          ListTile(title: SearchableText(text: definitionText))
        ],
        initiallyExpanded: false,
        horizontalPadding: Numbers.definitionTextHorizontalPadding,
        verticalPadding: Numbers.definitionTextVerticalPadding,
        dividerColor: DynamicTheme.dividerColor,
      );

      ret.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            texts,
          ],
        ),
      );
    }

    return ret;
  }
}
