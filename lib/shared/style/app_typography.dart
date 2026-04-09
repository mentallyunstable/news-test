import 'package:flutter/material.dart';

final class AppTypography {
  const AppTypography._();

  static TextTheme buildTextTheme(final TextTheme base) {
    return base.copyWith(
      headlineSmall: _textStyle(fontSize: 19, fontWeight: FontWeight.w500),
      headlineMedium: _textStyle(fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge: _textStyle(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: _textStyle(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: _textStyle(fontSize: 14, fontWeight: FontWeight.w400),
      labelLarge: _textStyle(fontSize: 17, fontWeight: FontWeight.w400),
      bodyLarge: _textStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: _textStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodySmall: _textStyle(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }

  static TextStyle _textStyle({
    required final double fontSize,
    required final FontWeight fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0,
    );
  }
}
