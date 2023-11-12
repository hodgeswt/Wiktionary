import 'package:dio/dio.dart';
import 'package:wiktionary/datamodel/results.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = "http://localhost:8000/word";

  Future<Results?> getDefinition(String searchLang, String searchTerm) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/$searchLang/$searchTerm',
      );

      Results results = Results.fromJson(response.data);

      return results;
    } catch (error) {
      throw Exception("Failed to get definition");
    }
  }
}
