import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_test/app/constant/assets_keys.dart';
import 'package:news_test/shared/constant/semantics_identifiers.dart';

final class NewsSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const NewsSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      textField: true,
      identifier: SemanticsIdentifiers.newsSearchField,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search news',
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: SvgPicture.asset(
              AssetsKeys.searchIcon,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 40,
          ),
        ),
      ),
    );
  }
}
