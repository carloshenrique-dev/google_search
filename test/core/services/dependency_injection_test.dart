import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_search/core/repository/api_repository.dart';
import 'package:google_search/core/services/api_service.dart';
import 'package:google_search/core/services/dependency_injection.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';

final di = GetIt.instance;

void main() {
  group('Service Locator Configuration', () {
    setUp(() {
      di.reset();
      initServiceLocator();
    });

    test('ApiRepository is registered as a lazy singleton', () {
      final apiRepository1 = di<ApiRepository>();
      final apiRepository2 = di<ApiRepository>();

      expect(apiRepository1, isA<ApiRepository>());
      expect(apiRepository2, isA<ApiRepository>());
      expect(apiRepository1, equals(apiRepository2));
    });

    test('ApiService is registered as a lazy singleton', () {
      final apiService1 = di<ApiService>();
      final apiService2 = di<ApiService>();

      expect(apiService1, isA<ApiService>());
      expect(apiService2, isA<ApiService>());
      expect(apiService1, equals(apiService2));
    });

    test('SearchCubit is registered as a lazy singleton', () {
      final searchCubit1 = di<SearchCubit>();
      final searchCubit2 = di<SearchCubit>();

      expect(searchCubit1, isA<SearchCubit>());
      expect(searchCubit2, isA<SearchCubit>());
      expect(searchCubit1, equals(searchCubit2));
    });
  });
}
