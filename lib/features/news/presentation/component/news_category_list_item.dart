import 'package:flutter/material.dart';
import 'package:news_test/features/news/domain/entity/news_category_entity.dart';

final class NewsCategoryListItem extends StatelessWidget {
  final NewsCategoryEntity category;
  final bool isSelected;
  final VoidCallback? onTap;

  const NewsCategoryListItem({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final splashColor = isSelected ? null : colorScheme.primary.withValues(alpha: 0.16);
    final highlightColor = isSelected ? null : colorScheme.primary.withValues(alpha: 0.08);
    final hoverColor = isSelected ? null : colorScheme.primary.withValues(alpha: 0.06);

    return SizedBox(
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surfaceContainer,
          borderRadius: const .all(.circular(22)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: const .all(.circular(22)),
            splashColor: splashColor,
            highlightColor: highlightColor,
            hoverColor: hoverColor,
            child: Padding(
              padding: const .symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  category.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).labelLarge?.copyWith(
                    color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                  strutStyle: const StrutStyle(
                    height: 1,
                    forceStrutHeight: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
