import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/news/bloc/news_bloc.dart';
import 'package:news_test/features/news/presentation/component/news_category_list_view.dart';
import 'package:news_test/features/news/presentation/component/news_list_view.dart';
import 'package:news_test/features/news/presentation/component/news_search_field.dart';
import 'package:news_test/shared/constant/semantics_identifiers.dart';
import 'package:news_test/shared/ui/dismiss_keyboard.dart';

final class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

final class _NewsScreenState extends State<NewsScreen> {
  late final TextEditingController _searchController = TextEditingController(
    text: context.read<NewsBloc>().state.data.searchQuery,
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        body: RefreshIndicator(
          displacement: MediaQuery.viewPaddingOf(context).top,
          onRefresh: () async {
            final bloc = context.read<NewsBloc>();
            bloc.add(const NewsBlocEvent.get());
            await bloc.doneLoading;
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<NewsBloc, NewsBlocState>(
                builder: (context, state) => SliverAppBar(
                  snap: true,
                  floating: true,
                  scrolledUnderElevation: 0,
                  titleSpacing: 19,
                  title: NewsSearchField(
                    controller: _searchController,
                    onChanged: (query) => context.read<NewsBloc>().add(
                      NewsBlocEvent.searchQueryChanged(query: query),
                    ),
                  ),
                  bottom: NewsCategoriesListView(
                    selectedCategory: state.data.selectedCategory,
                    onSelectCategory: (category) {
                      context.read<NewsBloc>().add(
                        NewsBlocEvent.selectCategory(category: category),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<NewsBloc, NewsBlocState>(
                builder: (context, state) {
                  final news = state.isSearching ? state.data.searchResults : state.data.news;

                  if (state is ErrorNewsBlocState) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Semantics(
                            container: true,
                            identifier: SemanticsIdentifiers.newsErrorMessageText,
                            child: Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is LoadingNewsBlocState && news.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Semantics(
                          container: true,
                          identifier: SemanticsIdentifiers.newsLoadingIndicator,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  if (news.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Semantics(
                          container: true,
                          identifier: SemanticsIdentifiers.newsEmptyStateText,
                          child: const Text('No news available'),
                        ),
                      ),
                    );
                  }

                  return NewsListView(news: news);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
