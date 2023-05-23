import 'package:google_search/core/models/google_search_model.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchState', () {
    test('copyWith creates a new instance with the provided values', () {
      const state = SearchState.initial();
      final newState = state.copyWith(
        status: SearchStatus.loading,
        list: [GoogleSearchModel(title: 'Result 1')],
      );

      expect(newState.status, SearchStatus.loading);
      expect(newState.list.length, 1);
      expect(newState.list[0].title, 'Result 1');
    });

    test('copyWith returns the same instance when no values are provided', () {
      const state = SearchState.initial();
      final newState = state.copyWith();

      expect(newState, state);
    });

    test('props returns a list of status and list', () {
      const state = SearchState.initial();
      expect(state.props, [SearchStatus.initial, []]);

      final newState = state.copyWith(
        status: SearchStatus.loading,
        list: [GoogleSearchModel(title: 'Result 1')],
      );
      expect(newState.props, [
        SearchStatus.loading,
        [GoogleSearchModel(title: 'Result 1')]
      ]);
    });

    test('equals returns true when two instances have the same values', () {
      const state1 = SearchState.initial();
      const state2 = SearchState.initial();

      expect(state1 == state2, true);
    });

    test('equals returns false when two instances have different values', () {
      const state1 = SearchState.initial();
      final state2 =
          const SearchState.initial().copyWith(status: SearchStatus.loading);

      expect(state1 == state2, false);
    });
  });
}
