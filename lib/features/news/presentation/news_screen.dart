import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/news/bloc/news_bloc.dart';
import 'package:news_test/features/news/presentation/component/news_category_list_view.dart';
import 'package:news_test/features/news/presentation/component/news_list_view.dart';

final class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

final class _NewsScreenState extends State<NewsScreen> {
  int _selectedCategoryIndex = 0;

  void _onSelectCategory(final int index, final String category) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: RefreshIndicator(
        displacement: MediaQuery.viewPaddingOf(context).top,
        onRefresh: () async {
          final bloc = context.read<NewsBloc>();
          bloc.add(const NewsBlocEvent.get());
          await bloc.doneLoading;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: const Text('News'),
              bottom: NewsCategoriesListView(
                selectedCategoryIndex: _selectedCategoryIndex,
                onSelectCategory: _onSelectCategory,
              ),
            ),
            BlocBuilder<NewsBloc, NewsBlocState>(
              builder: (context, state) {
                final news = state.data.news;

                if (state is LoadingNewsBlocState && news.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is ErrorNewsBlocState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          state.message,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }

                if (news.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text('No news available'),
                    ),
                  );
                }

                return NewsListView(news: news);
              },
            ),
          ],
        ),
      ),
    );
  }
}
