// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Definition _$DefinitionFromJson(Map<String, dynamic> json) => Definition(
      partOfSpeech: json['partOfSpeech'] as String,
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      examples:
          (json['examples'] as List<dynamic>).map((e) => e as String).toList(),
      relatedWords: (json['relatedWords'] as List<dynamic>)
          .map((e) => RelatedWords.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DefinitionToJson(Definition instance) =>
    <String, dynamic>{
      'partOfSpeech': instance.partOfSpeech,
      'text': instance.text,
      'examples': instance.examples,
      'relatedWords': instance.relatedWords,
    };
