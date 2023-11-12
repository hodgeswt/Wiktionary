// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pronunciations _$PronunciationsFromJson(Map<String, dynamic> json) =>
    Pronunciations(
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      audio: (json['audio'] as List<dynamic>)
          .map((e) => Audio.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PronunciationsToJson(Pronunciations instance) =>
    <String, dynamic>{
      'audio': instance.audio,
      'text': instance.text,
    };
