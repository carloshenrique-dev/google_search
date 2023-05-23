import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/google_search_model.dart';
import '../repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<List<GoogleSearchModel>> search(String query,
      {http.Client? client}) async {
    try {
      final httpClient = client ?? http.Client();
      final url = Uri.parse('http://172.24.80.1:8080/search/$query');
      final request = http.Request('GET', url);
      const timeout = Duration(seconds: 5);

      final response = await httpClient.send(request).timeout(timeout);

      if (response.statusCode == 200) {
        final decodedBody = await response.stream.bytesToString();
        final decodedJson = json.decode(decodedBody);
        final list = decodedJson['items'] as List?;

        if (list == null || list.isEmpty) {
          return [];
        }

        return list.map<GoogleSearchModel>((source) {
          return GoogleSearchModel.fromMap(source);
        }).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
