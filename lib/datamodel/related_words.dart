import 'package:json_annotation/json_annotation.dart';

part 'related_words.g.dart';

@JsonSerializable()
class RelatedWords {
  RelatedWords({
    required this.relationshipType,
    required this.words,
  });

  String relationshipType;
  List<String> words;

  factory RelatedWords.fromJson(Map<String, dynamic> json) =>
      _$RelatedWordsFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedWordsToJson(this);
}
