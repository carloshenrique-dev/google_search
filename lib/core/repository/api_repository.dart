import '../models/google_search_model.dart';

abstract interface class ApiRepository {
  Future<List<GoogleSearchModel>> search(String query);
}
