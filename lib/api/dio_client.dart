import 'package:dio/dio.dart';
import 'package:wiktionary/datamodel/results.dart';
import 'package:wiktionary/settings.dart';

class DioClient {
  DioClient();

  final Dio _dio = Dio();

  dynamic data = {};

  Future<Results?> getDefinition(String searchLang, String searchTerm) async {
    final response = await _dio.post(
      Settings.apiHost,
      data: {
        "word": searchTerm,
        "lang": searchLang,
      },
    );

    data = response.data;
    Results results = Results.fromJson(response.data);

    return results;
  }
}
