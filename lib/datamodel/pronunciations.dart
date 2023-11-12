import 'package:json_annotation/json_annotation.dart';
import 'package:wiktionary/datamodel/audio.dart';

part 'pronunciations.g.dart';

@JsonSerializable()
class Pronunciations {
  Pronunciations({
    required this.text,
    required this.audio,
  });

  List<Audio> audio;
  List<String> text;

  factory Pronunciations.fromJson(Map<String, dynamic> json) =>
      _$PronunciationsFromJson(json);
  Map<String, dynamic> toJson() => _$PronunciationsToJson(this);
}
