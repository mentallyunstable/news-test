import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_test/app/constant/assets_keys.dart';
import 'package:news_test/shared/style/app_theme.dart';

/// Minimal shell wrapper for branched navigation.
final class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.shell,
  });

  final StatefulNavigationShell shell;

  static const _navigationItems = <_NavigationItemData>[
    _NavigationItemData(
      iconPath: AssetsKeys.newsNavigationIcon,
      activeIconPath: AssetsKeys.newsActiveNavigationIcon,
    ),
    _NavigationItemData(
      iconPath: AssetsKeys.favoritesNavigationIcon,
      activeIconPath: AssetsKeys.favoritesActiveNavigationIcon,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navBarHeight =
        Theme.of(context).extension<AppThemeExtensions>()?.navBarHeight ?? 84;

    return Scaffold(
      body: shell,
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19).copyWith(
          bottom: MediaQuery.viewPaddingOf(context).bottom,
        ),
        // Because of design preferences we must implement custom navigation bar
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 6.1,
                spreadRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Material(
              color: Colors.white,
              child: SizedBox(
                height: navBarHeight,
                child: Row(
                  children: List.generate(
                    _navigationItems.length,
                    (index) => Expanded(
                      child: _NavigationItem(
                        data: _navigationItems[index],
                        isSelected: shell.currentIndex == index,
                        onTap: () => _onNavigationChange(context, index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onNavigationChange(final BuildContext context, final int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }
}

final class _NavigationItemData {
  final String iconPath;
  final String activeIconPath;

  const _NavigationItemData({
    required this.iconPath,
    required this.activeIconPath,
  });
}

final class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  final _NavigationItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconPath = isSelected ? data.activeIconPath : data.iconPath;

    return InkResponse(
      onTap: onTap,
      enableFeedback: true,
      child: Center(
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
