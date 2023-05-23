import 'dart:convert';
import 'package:google_search/core/repository/api_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiRepositoryImpl', () {
    late ApiRepositoryImpl apiRepository;
    late http.Client mockClient;

    setUp(() {
      mockClient = MockClient((request) async {
        // Simulate the API response
        if (request.url.toString() == 'http://172.24.80.1:8080/search/query') {
          final responseBody = {
            'items': [
              {'title': 'Result 1', 'link': 'https://example.com/result1'},
              {'title': 'Result 2', 'link': 'https://example.com/result2'},
              {'title': 'Result 3', 'link': 'https://example.com/result3'},
            ]
          };
          return http.Response(json.encode(responseBody), 200);
        }
        // Simulate an empty response
        return http.Response(json.encode({}), 200);
      });
      apiRepository = ApiRepositoryImpl();
    });

    test('search should return a list of GoogleSearchModel', () async {
      final results = await apiRepository.search('query', client: mockClient);

      expect(results.length, 3);
      expect(results[0].title, 'Result 1');
      expect(results[0].link, 'https://example.com/result1');
      expect(results[1].title, 'Result 2');
      expect(results[1].link, 'https://example.com/result2');
      expect(results[2].title, 'Result 3');
      expect(results[2].link, 'https://example.com/result3');
    });

    test('search should return an empty list when API response is empty',
        () async {
      final results = await apiRepository.search('empty', client: mockClient);

      expect(results.isEmpty, true);
    });

    test('search should return an empty list when API request fails', () async {
      final errorClient = MockClient((request) async {
        throw Exception('API request failed');
      });

      final results = await apiRepository.search('query', client: errorClient);

      expect(results.isEmpty, true);
    });
  });
}
