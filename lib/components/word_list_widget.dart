import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';

class WordListWidget extends StatelessWidget {
  final List<Word> words;

  const WordListWidget(this.words, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: words
            .map((word) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        word.arabic,
                        style: const TextStyle(fontSize: 48),
                      ),
                      subtitle: Text(
                        word.meaning,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}
