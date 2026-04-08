import 'package:flutter/material.dart';

final class AppTypography {
  const AppTypography._();

  static TextTheme buildTextTheme(final TextTheme base) {
    return base.copyWith(
      headlineSmall: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 19,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: 0,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: 0,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: 0,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
      ),
    );
  }
}
