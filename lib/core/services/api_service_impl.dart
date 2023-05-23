import '../models/google_search_model.dart';
import '../repository/api_repository.dart';
import 'api_service.dart';

class ApiServiceImpl implements ApiService {
  final ApiRepository _apiRepository;

  ApiServiceImpl({
    required ApiRepository apiRepository,
  }) : _apiRepository = apiRepository;

  @override
  Future<List<GoogleSearchModel>> search(String query) async =>
      await _apiRepository.search(query);
}
