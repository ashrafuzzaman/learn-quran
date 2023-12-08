import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_helper.dart';

class WordIcon extends StatelessWidget {
  final Word word;

  const WordIcon({
    required this.word,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (word.gender == null && word.plurality == null) {
      return const SizedBox.shrink();
    }

    var color = getWordIconColor(context, word);

    Map icons = {
      Plurality.singular: Tooltip(
          message: "Singular",
          child: Icon(
            Icons.person,
            color: color,
          )),
      Plurality.dual: Tooltip(
          message: "Dual",
          child: Icon(
            Icons.people_alt,
            color: color,
          )),
      Plurality.plural: Tooltip(
          message: "Plural",
          child: Icon(
            Icons.group_add,
            color: color,
          )),
    };

    final Widget pluralityIcon = icons[word.plurality];

    return pluralityIcon;
  }
}
