import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  double wp(double percent) => width * (percent / 100);
  double hp(double percent) => height * (percent / 100);

  double sp(double size) {
    // Base width for scaling (standard mobile)
    double scale = width / 375;
    // Cap the scale to prevent massive text on desktop
    if (scale > 1.3) scale = 1.3;
    return size * scale;
  }

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width <= 1024;
  bool get isDesktop => width > 1024;

  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}
