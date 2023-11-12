import 'package:json_annotation/json_annotation.dart';
import 'package:wiktionary/datamodel/related_words.dart';

part 'definition.g.dart';

@JsonSerializable()
class Definition {
  Definition({
    required this.partOfSpeech,
    required this.text,
    required this.examples,
    required this.relatedWords,
  });

  String partOfSpeech;
  List<String> text;
  List<String> examples;
  List<RelatedWords> relatedWords;

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);
  Map<String, dynamic> toJson() => _$DefinitionToJson(this);
}
