import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_test/shared/style/app_colors.dart';
import 'package:news_test/shared/style/app_typography.dart';

final class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Satoshi',
    extensions: _extensions,
    textTheme: AppTypography.buildTextTheme(
      ThemeData(
        useMaterial3: true,
        fontFamily: 'Satoshi',
        brightness: Brightness.light,
      ).textTheme,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surface,
      surfaceContainer: AppColors.surfaceContainer,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      actionsPadding: .symmetric(horizontal: 8),
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Satoshi',
    extensions: _extensions,
    textTheme: AppTypography.buildTextTheme(
      ThemeData(
        useMaterial3: true,
        fontFamily: 'Satoshi',
        brightness: Brightness.dark,
      ).textTheme,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),
  );

  static const _extensions = <ThemeExtension<dynamic>>[
    AppThemeExtensions(navBarHeight: 84),
  ];
}

final class AppThemeExtensions extends ThemeExtension<AppThemeExtensions> {
  final double navBarHeight;

  const AppThemeExtensions({required this.navBarHeight});

  @override
  AppThemeExtensions copyWith({
    final double? navBarHeight,
  }) {
    return AppThemeExtensions(navBarHeight: navBarHeight ?? this.navBarHeight);
  }

  @override
  AppThemeExtensions lerp(
    covariant final ThemeExtension<AppThemeExtensions>? other,
    final double t,
  ) {
    if (other is! AppThemeExtensions) return this;

    return AppThemeExtensions(
      navBarHeight: lerpDouble(navBarHeight, other.navBarHeight, t) ?? navBarHeight,
    );
  }
}
