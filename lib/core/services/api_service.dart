import '../models/google_search_model.dart';

abstract interface class ApiService {
  Future<List<GoogleSearchModel>> search(String query);
}
