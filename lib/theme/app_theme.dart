import 'package:flutter/material.dart';
import 'package:learnquran/theme/app_colors.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        defaultWordBackground:
            isDarkTheme ? Colors.amber[50] : Colors.amber.shade50,
        maleWordBackground:
            isDarkTheme ? Colors.blue.shade100 : Colors.blue.shade50,
        femaleWordBackground: isDarkTheme ? Colors.pink : Colors.pink.shade50,
      )
    ],
  );
}
