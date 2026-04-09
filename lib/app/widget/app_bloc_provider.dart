import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/app/dependencies/extensions/context_extension.dart';
import 'package:news_test/features/favorites/bloc/favorites_bloc.dart';
import 'package:news_test/features/news/bloc/news_bloc.dart';

/// Root place for app-wide blocs.
final class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoritesBloc(
            favoriteArticlesLocalDataSource: context.localDataSources.favoriteArticlesLocalDataSource(),
          )..add(const FavoritesBlocEvent.get()),
        ),
        BlocProvider(
          create: (_) => NewsBloc(
            repository: context.repositories.newsRepository(),
          )..add(const NewsBlocEvent.get()),
        ),
      ],
      child: child,
    );
  }
}
