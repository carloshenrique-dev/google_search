import 'package:flutter_test/flutter_test.dart';
import 'package:google_search/core/models/google_search_model.dart';
import 'package:google_search/core/services/api_service.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';

import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late SearchCubit searchCubit;
  late ApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    searchCubit = SearchCubit(apiService: mockApiService);
  });

  test('SearchCubit initializes with initial state', () {
    expect(searchCubit.state, const SearchState.initial());
  });

  test(
      'SearchCubit emits loading and completed states when search is successful',
      () async {
    const query = 'search query';
    final searchResultList = [
      GoogleSearchModel(title: 'Result 1', link: 'https://example.com/result1'),
      GoogleSearchModel(title: 'Result 2', link: 'https://example.com/result2'),
    ];

    // Simulate successful search result
    when(() => mockApiService.search(query))
        .thenAnswer((_) => Future.value(searchResultList));

    await searchCubit.search(query);

    expect(searchCubit.state.status, SearchStatus.completed);
    expect(searchCubit.state.list, searchResultList);
  });

  test('SearchCubit emits loading and error states when search result is empty',
      () async {
    const query = 'search query';

    // Simulate empty search result
    when(() => mockApiService.search(query))
        .thenAnswer((_) => Future.value([]));

    await searchCubit.search(query);

    expect(searchCubit.state.status, SearchStatus.error);
    expect(searchCubit.state.list, []);
  });

  test(
      'SearchCubit emits loading and error states when search encounters an error',
      () async {
    const query = 'search query';

    // Simulate error during search
    when(() => mockApiService.search(query))
        .thenThrow(Exception('API request failed'));

    await searchCubit.search(query);

    expect(searchCubit.state.status, SearchStatus.error);
    expect(searchCubit.state.list, []);
  });
}
