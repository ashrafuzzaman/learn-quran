import 'package:flutter/material.dart';

class ThemeExtensionColors extends ThemeExtension<ThemeExtensionColors> {
  final Color? defaultWordBackground;
  final Color? maleWordBackground;
  final Color? femaleWordBackground;

  final Color? success;
  final Color? failure;

  final Color? defaultWordIcon;
  final Color? maleWordIcon;
  final Color? femaleWordIcon;

  const ThemeExtensionColors({
    required this.success,
    required this.failure,
    required this.defaultWordBackground,
    required this.maleWordBackground,
    required this.femaleWordBackground,
    required this.defaultWordIcon,
    required this.maleWordIcon,
    required this.femaleWordIcon,
  });

  @override
  ThemeExtensionColors copyWith({
    Color? success,
    Color? failure,
    Color? defaultWordBackground,
    Color? maleWordBackground,
    Color? femaleWordBackground,
    Color? defaultWordIcon,
    Color? maleWordIcon,
    Color? femaleWordIcon,
  }) {
    return ThemeExtensionColors(
      success: success ?? this.success,
      failure: failure ?? this.failure,
      defaultWordBackground:
          defaultWordBackground ?? this.defaultWordBackground,
      maleWordBackground: maleWordBackground ?? this.maleWordBackground,
      femaleWordBackground: femaleWordBackground ?? this.femaleWordBackground,
      defaultWordIcon: defaultWordIcon ?? this.defaultWordIcon,
      maleWordIcon: maleWordIcon ?? this.maleWordIcon,
      femaleWordIcon: femaleWordIcon ?? this.femaleWordIcon,
    );
  }

  @override
  ThemeExtensionColors lerp(
      ThemeExtension<ThemeExtensionColors>? other, double t) {
    if (other is! ThemeExtensionColors) {
      return this;
    }
    return ThemeExtensionColors(
      success: Color.lerp(success, other.success, t),
      failure: Color.lerp(failure, other.failure, t),
      defaultWordBackground:
          Color.lerp(defaultWordBackground, other.defaultWordBackground, t),
      maleWordBackground:
          Color.lerp(maleWordBackground, other.maleWordBackground, t),
      femaleWordBackground:
          Color.lerp(femaleWordBackground, other.femaleWordBackground, t),
      defaultWordIcon: Color.lerp(defaultWordIcon, other.defaultWordIcon, t),
      maleWordIcon: Color.lerp(maleWordIcon, other.maleWordIcon, t),
      femaleWordIcon: Color.lerp(femaleWordIcon, other.femaleWordIcon, t),
    );
  }
}
