import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_extension_colors.dart';
import 'package:learnquran/theme/theme_helper.dart';

class WordIcon extends StatelessWidget {
  final Word word;

  const WordIcon({
    required this.word,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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

    return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [pluralityIcon]));
  }
}
