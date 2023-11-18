import 'package:dio/dio.dart';
import 'package:wiktionary/datamodel/results.dart';
import 'package:wiktionary/settings.dart';

class DioClient {
  DioClient();

  final Dio _dio = Dio();

  String _baseUrl() => "http://${Settings.apiHost}:${Settings.apiPort}/word";
  String _fullUrl(String searchLang, String searchTerm) =>
      "${_baseUrl()}/$searchLang/$searchTerm";

  dynamic data = {};

  Future<Results?> getDefinition(String searchLang, String searchTerm) async {
    final response = await _dio.get(
      _fullUrl(searchLang, searchTerm),
    );

    data = response.data;
    Results results = Results.fromJson(response.data);

    return results;
  }
}
