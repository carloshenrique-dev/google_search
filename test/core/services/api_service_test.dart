import 'package:flutter_test/flutter_test.dart';
import 'package:google_search/core/models/google_search_model.dart';
import 'package:google_search/core/repository/api_repository.dart';
import 'package:google_search/core/services/api_service_impl.dart';

import 'package:mocktail/mocktail.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  group('ApiServiceImpl', () {
    late ApiServiceImpl apiService;
    late MockApiRepository mockApiRepository;

    setUp(() {
      mockApiRepository = MockApiRepository();
      apiService = ApiServiceImpl(apiRepository: mockApiRepository);
    });

    test('search calls ApiRepository.search with the provided query', () async {
      const query = 'example';
      final expectedResults = [
        GoogleSearchModel(
            link: 'https://www.example.com', title: 'Example Title 1'),
        GoogleSearchModel(
            link: 'https://www.example2.com', title: 'Example Title 2'),
      ];

      when(() => mockApiRepository.search(query))
          .thenAnswer((_) async => expectedResults);

      final results = await apiService.search(query);

      expect(results, expectedResults);
      verify(() => mockApiRepository.search(query)).called(1);
    });
  });
}
