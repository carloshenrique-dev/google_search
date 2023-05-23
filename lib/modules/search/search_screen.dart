import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_search/modules/search/widgets/card_widget.dart';

import 'cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  final SearchCubit controller;
  const SearchScreen({
    super.key,
    required this.controller,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.controller,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        return Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            decoration: const InputDecoration(
                              hintText: 'Digite aqui sua pesquisa...',
                            ),
                            onSubmitted: (_) async {
                              if (_textEditingController.text.isNotEmpty) {
                                await context
                                    .read<SearchCubit>()
                                    .search(_textEditingController.text);
                              }
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () async {
                            if (_textEditingController.text.isNotEmpty) {
                              await context
                                  .read<SearchCubit>()
                                  .search(_textEditingController.text);
                            }
                          },
                          icon: const Icon(Icons.search),
                          splashColor: Colors.transparent,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case SearchStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case SearchStatus.completed:
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.list.length,
                          separatorBuilder: (_, __) {
                            return Divider(
                              color: Colors.grey[300],
                              height: 2,
                            );
                          },
                          itemBuilder: (_, index) {
                            final item = state.list[index];
                            return CardWidget(googleSearchModel: item);
                          },
                        );

                      case SearchStatus.initial:
                        return const SizedBox.shrink();

                      case SearchStatus.error:
                        return const Center(
                          child: Text('Error'),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
