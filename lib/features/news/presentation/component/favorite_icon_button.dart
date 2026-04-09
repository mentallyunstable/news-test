import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_test/app/constant/assets_keys.dart';

final class FavoriteIconButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(isFavorite ? AssetsKeys.favoriteFilledIcon : AssetsKeys.favoriteIcon),
    );
  }
}
