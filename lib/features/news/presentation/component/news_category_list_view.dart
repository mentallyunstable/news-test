import 'package:flutter/material.dart';
import 'package:news_test/features/news/domain/entity/news_category_entity.dart';
import 'package:news_test/features/news/presentation/component/news_category_list_item.dart';
import 'package:news_test/shared/constant/semantics_identifiers.dart';

typedef CategorySelectedCallback = void Function(String category);

final class NewsCategoriesListView extends StatelessWidget implements PreferredSizeWidget {
  final String selectedCategory;
  final CategorySelectedCallback onSelectCategory;

  const NewsCategoriesListView({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  static const _categories = <NewsCategoryEntity>[
    NewsCategoryEntity(name: 'General', value: 'general'),
    NewsCategoryEntity(name: 'Health', value: 'health'),
    NewsCategoryEntity(name: 'Business', value: 'business'),
    NewsCategoryEntity(name: 'Entertainment', value: 'entertainment'),
    NewsCategoryEntity(name: 'Science', value: 'science'),
    NewsCategoryEntity(name: 'Sports', value: 'sports'),
    NewsCategoryEntity(name: 'Technology', value: 'technology'),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 19),
        itemCount: _categories.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, _) => const SizedBox(width: 7),
        itemBuilder: (_, index) {
          final category = _categories[index];

          return NewsCategoryListItem(
            category: category,
            isSelected: category.value == selectedCategory,
            onTap: () => onSelectCategory(category.value),
            semanticsIdentifier: SemanticsIdentifiers.newsCategoryChip(
              category.value,
            ),
          );
        },
      ),
    );
  }
}
