import 'package:flutter/material.dart';
import 'package:learnquran/widgets/word/word_icon.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_helper.dart';

class WordListWidget extends StatelessWidget {
  final List<Word> words;
  final Function(int selectedIndex) hanleTap;

  const WordListWidget(this.words, this.hanleTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles: words.map((word) => ListTile(
                contentPadding: const EdgeInsets.all(5),
                title: Text(word.arabic, style: const TextStyle(fontSize: 48)),
                onTap: () {
                  hanleTap(word.id);
                },
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(word.meaning, style: const TextStyle(fontSize: 24)),
                      WordIcon(word: word)
                    ]),
              ))).toList(),
    );
  }
}
