import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';

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
          title: ArabicText(
            word.arabic,
            textAlign: TextAlign.center,
            fontSize: 24,
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
