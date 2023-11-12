import 'package:json_annotation/json_annotation.dart';
import 'package:wiktionary/datamodel/definition.dart';
import 'package:wiktionary/datamodel/pronunciations.dart';

part 'result_data.g.dart';

@JsonSerializable()
class ResultData {
  ResultData({
    required this.etymology,
    required this.definitions,
    required this.pronunciations,
  });

  String etymology;
  List<Definition> definitions;
  Pronunciations pronunciations;

  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
