// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      etymology: json['etymology'] as String,
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => Definition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'etymology': instance.etymology,
      'definitions': instance.definitions,
    };
