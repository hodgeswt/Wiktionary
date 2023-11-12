import 'package:json_annotation/json_annotation.dart';
import 'package:wiktionary/datamodel/result_data.dart';

part 'results.g.dart';

@JsonSerializable()
class Results {
  Results({
    required this.results,
  });

  List<ResultData> results;

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
