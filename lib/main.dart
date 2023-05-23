import 'package:flutter/material.dart';
import 'package:google_search/core/services/dependency_injection.dart';
import 'package:google_search/modules/search/cubit/search_cubit.dart';
import 'package:google_search/modules/search/search_screen.dart';

void main() {
  initServiceLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Search',
      home: SearchScreen(
        controller: di<SearchCubit>(),
      ),
    );
  }
}
