import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';

class WordIcon extends StatelessWidget {
  final Word word;

  const WordIcon({
    required this.word,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map icons = {
      Plurality.singular:
          const Tooltip(message: "Singular", child: Icon(Icons.person)),
      Plurality.dual:
          const Tooltip(message: "Dual", child: Icon(Icons.people_alt)),
      Plurality.plural:
          const Tooltip(message: "Plural", child: Icon(Icons.group_add)),
    };

    final Widget pluralityIcon = icons[word.plurality];

    return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [pluralityIcon]));
  }
}
