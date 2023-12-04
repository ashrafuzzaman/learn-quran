import 'package:flutter/material.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';

ThemeExtensionColors colors(context) =>
    Theme.of(context).extension<ThemeExtensionColors>()!;

ThemeData getLightTheme() {
  return ThemeData(
    extensions: <ThemeExtension<ThemeExtensionColors>>[
      ThemeExtensionColors(
        defaultWordBackground: Colors.amber.shade300,
        maleWordBackground: Colors.blue.shade200,
        femaleWordBackground: Colors.pink.shade200,
        defaultWordIcon: Colors.amber.shade900,
        maleWordIcon: Colors.blue.shade900,
        femaleWordIcon: Colors.pink.shade600,
      )
    ],
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    extensions: <ThemeExtension<ThemeExtensionColors>>[
      ThemeExtensionColors(
        defaultWordBackground: Colors.amber.shade300,
        maleWordBackground: Colors.blue.shade200,
        femaleWordBackground: Colors.pink.shade200,
        defaultWordIcon: Colors.amber.shade300,
        maleWordIcon: Colors.blue.shade200,
        femaleWordIcon: Colors.pink.shade200,
      )
    ],
  );
}
