import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_test/app/constant/assets_keys.dart';

final class AppBackButtonIcon extends StatelessWidget {
  const AppBackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsKeys.leadingBackArrowIcon);
  }
}
