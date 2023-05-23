import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_search/core/models/google_search_model.dart';
import 'package:google_search/core/services/api_service.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';
import 'package:google_search/modules/search/widgets/card_widget.dart';

import 'package:google_search/modules/search/search_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late SearchCubit searchCubit;
  late Widget searchScreen;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    searchCubit = SearchCubit(apiService: mockApiService);
    searchScreen = MaterialApp(
      home: SearchScreen(controller: searchCubit),
    );
  });

  testWidgets('SearchScreen displays TextField and search button',
      (WidgetTester tester) async {
    await tester.pumpWidget(searchScreen);

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('SearchScreen displays CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    searchCubit.emit(searchCubit.state.copyWith(status: SearchStatus.loading));

    await tester.pumpWidget(searchScreen);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('SearchScreen displays CardWidget for each search result',
      (WidgetTester tester) async {
    final searchResultList = [
      GoogleSearchModel(title: 'Result 1', link: 'https://example.com/result1'),
      GoogleSearchModel(title: 'Result 2', link: 'https://example.com/result2'),
    ];
    searchCubit.emit(searchCubit.state
        .copyWith(status: SearchStatus.completed, list: searchResultList));

    await tester.pumpWidget(searchScreen);

    expect(find.byType(CardWidget), findsNWidgets(searchResultList.length));
  });

  testWidgets('SearchScreen displays "Error" when search encounters an error',
      (WidgetTester tester) async {
    searchCubit.emit(searchCubit.state.copyWith(status: SearchStatus.error));

    await tester.pumpWidget(searchScreen);

    expect(find.text('Error'), findsOneWidget);
  });
}
