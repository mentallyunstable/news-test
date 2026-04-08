import 'package:flutter/material.dart';
import 'package:news_test/features/news/domain/entity/news_category_entity.dart';
import 'package:news_test/features/news/presentation/component/news_category_list_item.dart';

typedef CategorySelectedCallback = void Function(int index, String category);

final class NewsCategoriesListView extends StatelessWidget implements PreferredSizeWidget {
  final int selectedCategoryIndex;
  final CategorySelectedCallback onSelectCategory;

  const NewsCategoriesListView({
    super.key,
    required this.selectedCategoryIndex,
    required this.onSelectCategory,
  });

  static const _categories = <NewsCategoryEntity>[
    NewsCategoryEntity(name: 'Business', value: 'business'),
    NewsCategoryEntity(name: 'Entertainment', value: 'entertainment'),
    NewsCategoryEntity(name: 'General', value: 'General'),
    NewsCategoryEntity(name: 'Health', value: 'health'),
    NewsCategoryEntity(name: 'Science', value: 'science'),
    NewsCategoryEntity(name: 'Sports', value: 'sports'),
    NewsCategoryEntity(name: 'Technology', value: 'technology'),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 19).copyWith(bottom: 8),
        itemCount: _categories.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, _) => const SizedBox(width: 7),
        itemBuilder: (_, index) => NewsCategoryListItem(
          category: _categories[index],
          isSelected: index == selectedCategoryIndex,
        ),
      ),
    );
  }
}
