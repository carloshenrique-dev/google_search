part of 'search_cubit.dart';

enum SearchStatus { initial, loading, completed, error }

class SearchState extends Equatable {
  const SearchState.initial()
      : this._(
          status: SearchStatus.initial,
        );

  const SearchState._({
    required this.status,
    this.list = const [],
  });

  final SearchStatus status;
  final List<GoogleSearchModel> list;

  SearchState copyWith({
    SearchStatus? status,
    List<GoogleSearchModel>? list,
  }) {
    return SearchState._(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [status, list];
}
