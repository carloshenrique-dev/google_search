import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_search/core/repository/api_repository.dart';
import 'package:google_search/core/services/api_service.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockApiRepository extends Mock implements ApiRepository {}

class MockApiService extends Mock implements ApiService {}

class MockSearchCubit extends Mock implements SearchCubit {}

void main() {
  late GetIt getIt;

  setUp(() {
    getIt = GetIt.instance;
  });

  test('initServiceLocator should register the dependencies correctly', () {
    final mockApiRepository = MockApiRepository();
    final mockApiService = MockApiService();
    final mockSearchCubit = MockSearchCubit();

    getIt.registerFactory<ApiRepository>(() => mockApiRepository);
    getIt.registerFactory<ApiService>(() => mockApiService);
    getIt.registerFactory<SearchCubit>(() => mockSearchCubit);

    expect(getIt<ApiRepository>(), mockApiRepository);
    expect(getIt<ApiService>(), mockApiService);
    expect(getIt<SearchCubit>(), mockSearchCubit);
  });
}
