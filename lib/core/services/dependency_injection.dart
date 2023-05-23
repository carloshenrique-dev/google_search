import 'package:get_it/get_it.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';

import '../repository/api_repository.dart';
import '../repository/api_repository_impl.dart';
import 'api_service.dart';
import 'api_service_impl.dart';

final di = GetIt.instance;

Future<void> initServiceLocator() async {
  di.registerFactory<ApiRepository>(
    () => ApiRepositoryImpl(),
  );

  di.registerFactory<ApiService>(
      () => ApiServiceImpl(apiRepository: di<ApiRepository>()));

  di.registerFactory<SearchCubit>(
    () => SearchCubit(
      apiService: di<ApiService>(),
    ),
  );
}
