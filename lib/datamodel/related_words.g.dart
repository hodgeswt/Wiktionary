// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_words.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedWords _$RelatedWordsFromJson(Map<String, dynamic> json) => RelatedWords(
      relationshipType: json['relationshipType'] as String,
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RelatedWordsToJson(RelatedWords instance) =>
    <String, dynamic>{
      'relationshipType': instance.relationshipType,
      'words': instance.words,
    };
