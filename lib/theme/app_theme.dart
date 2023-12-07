import 'package:flutter/material.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';

ThemeExtensionColors colors(context) =>
    Theme.of(context).extension<ThemeExtensionColors>()!;

ThemeData getLightTheme() {
  return ThemeData(
    extensions: <ThemeExtension<ThemeExtensionColors>>[
      ThemeExtensionColors(
        defaultWordBackground: Colors.amber.shade100,
        maleWordBackground: Colors.blue.shade50,
        femaleWordBackground: Colors.pink.shade50,
        defaultWordIcon: Colors.amber.shade900,
        maleWordIcon: Colors.blue.shade400,
        femaleWordIcon: Colors.pink.shade400,
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
