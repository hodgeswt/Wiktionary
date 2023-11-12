import 'package:json_annotation/json_annotation.dart';

part 'audio.g.dart';

@JsonSerializable()
class Audio {
  Audio({
    required this.text,
  });

  List<String> text;

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);
  Map<String, dynamic> toJson() => _$AudioToJson(this);
}
