import 'dart:math';

import 'package:flutter/cupertino.dart';

extension ScreenSizeCalculator on MediaQueryData {
  static const double baseWidth = 360; // Base width for design
  static const double baseHeight = 800; // Base height for design

  double get widthFactor => size.width / baseWidth;

  double get heightFactor => size.height / baseHeight;

  /// Calculates width based on the design's base width.
  double calculateWidth(final double width) => max(width, width * widthFactor);

  /// Calculates height based on the design's base height.
  double calculateHeight(final double height) => max(height, height * heightFactor);
}

extension ScreenSizeContextCalculator on BuildContext {
  Size get _sizeOf => MediaQuery.of(this).size;

  double calculateWidth(final double width) => max(width, width * _sizeOf.width);

  double calculateHeight(final double height) => max(height, height * _sizeOf.height);
}
