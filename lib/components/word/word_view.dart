import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';

class WordView extends StatelessWidget {
  final Word word;

  const WordView(
    this.word, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ListTile(
          title: Text(
            word.arabic,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 48),
          ),
          subtitle: Text(
            word.meaning,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
