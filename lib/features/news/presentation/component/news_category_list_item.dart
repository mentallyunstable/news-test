import 'package:flutter/material.dart';
import 'package:news_test/features/news/domain/entity/news_category_entity.dart';

final class NewsCategoryListItem extends StatelessWidget {
  final NewsCategoryEntity category;
  final bool isSelected;

  const NewsCategoryListItem({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return SizedBox(
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surfaceContainer,
          borderRadius: const .all(.circular(16)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const .symmetric(vertical: 10, horizontal: 24),
              child: Text(
                category.name,
                style: TextTheme.of(context).bodyMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
