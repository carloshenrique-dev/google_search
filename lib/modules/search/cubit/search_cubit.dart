import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_search/core/services/api_service.dart';

import '../../../core/models/google_search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ApiService _apiService;
  SearchCubit({required ApiService apiService})
      : _apiService = apiService,
        super(const SearchState.initial());

  Future<void> search(String query) async {
    try {
      emit(state.copyWith(status: SearchStatus.loading));
      final result = await _apiService.search(query);
      if (result.isNotEmpty) {
        emit(state.copyWith(
          status: SearchStatus.completed,
          list: result,
        ));
      } else {
        emit(state.copyWith(
          status: SearchStatus.error,
          list: [],
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error));
    }
  }
}
