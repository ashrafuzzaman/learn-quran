import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/app_colors.dart';

Color? getWordBackgroundColor(BuildContext context, Word word) {
  AppColors colors(context) => Theme.of(context).extension<AppColors>()!;
  if (word.gender == null) return colors(context).defaultWordBackground;
  return word.gender == Gender.male
      ? colors(context).maleWordBackground
      : colors(context).femaleWordBackground;
}
