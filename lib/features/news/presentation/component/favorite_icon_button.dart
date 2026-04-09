import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_test/app/constant/assets_keys.dart';
import 'package:news_test/features/favorites/bloc/favorites_bloc.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';

final class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.article,
    this.padding,
    this.constraints,
  });

  final NewsArticleItemEntity article;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesBloc, FavoritesBlocState, bool>(
      selector: (state) => state.data.isFavorite(article.id),
      builder: (context, state) {
        final isFavorite = state;

        return IconButton(
          padding: padding,
          constraints: constraints,
          onPressed: () {
            final favoritesBloc = context.read<FavoritesBloc>();

            favoritesBloc.add(
              isFavorite ? FavoritesBlocEvent.remove(articleId: article.id) : FavoritesBlocEvent.add(article: article),
            );
          },
          icon: SvgPicture.asset(
            isFavorite ? AssetsKeys.favoriteFilledIcon : AssetsKeys.favoriteIcon,
          ),
        );
      },
    );
  }
}
