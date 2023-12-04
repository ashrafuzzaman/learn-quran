import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? defaultWordBackground;
  final Color? maleWordBackground;
  final Color? femaleWordBackground;

  const AppColors({
    required this.defaultWordBackground,
    required this.maleWordBackground,
    required this.femaleWordBackground,
  });

  @override
  AppColors copyWith({
    Color? defaultWordBackground,
    Color? maleWordBackground,
    Color? femaleWordBackground,
  }) {
    return AppColors(
      defaultWordBackground:
          defaultWordBackground ?? this.defaultWordBackground,
      maleWordBackground: maleWordBackground ?? this.maleWordBackground,
      femaleWordBackground: femaleWordBackground ?? this.femaleWordBackground,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      defaultWordBackground:
          Color.lerp(defaultWordBackground, other.defaultWordBackground, t),
      maleWordBackground:
          Color.lerp(maleWordBackground, other.maleWordBackground, t),
      femaleWordBackground:
          Color.lerp(femaleWordBackground, other.femaleWordBackground, t),
    );
  }
}
