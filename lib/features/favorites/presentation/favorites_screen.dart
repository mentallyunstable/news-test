import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/features/favorites/bloc/favorites_bloc.dart';
import 'package:news_test/features/news/presentation/component/news_list_view.dart';

final class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<FavoritesBloc, FavoritesBlocState>(
            builder: (context, state) {
              final favorites = state.data.favorites;

              if (state is LoadingFavoritesBlocState && favorites.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is ErrorFavoritesBlocState && favorites.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                );
              }

              if (favorites.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No favorite articles yet'),
                  ),
                );
              }

              return NewsListView(
                news: favorites,
                showFavoriteButton: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
