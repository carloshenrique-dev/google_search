import 'package:get_it/get_it.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';

import '../repository/api_repository.dart';
import '../repository/api_repository_impl.dart';
import 'api_service.dart';
import 'api_service_impl.dart';

final di = GetIt.instance;

initServiceLocator() {
  di.registerLazySingleton<ApiRepository>(
    () => ApiRepositoryImpl(),
  );

  di.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(
      apiRepository: di<ApiRepository>(),
    ),
  );

  di.registerLazySingleton<SearchCubit>(
    () => SearchCubit(
      apiService: di<ApiService>(),
    ),
  );
}
