import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';

Color? getWordBackgroundColor(BuildContext context, Word word) {
  ThemeExtensionColors colors(context) =>
      Theme.of(context).extension<ThemeExtensionColors>()!;
  if (word.gender == null) return colors(context).defaultWordBackground;
  return word.gender == Gender.male
      ? colors(context).maleWordBackground
      : colors(context).femaleWordBackground;
}

Color? getWordIconColor(BuildContext context, Word word) {
  ThemeExtensionColors colors(context) =>
      Theme.of(context).extension<ThemeExtensionColors>()!;
  if (word.gender == null) return colors(context).defaultWordIcon;
  return word.gender == Gender.male
      ? colors(context).maleWordIcon
      : colors(context).femaleWordIcon;
}
