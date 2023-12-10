import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/widgets/word/word_flipcard.dart';

class WordsFlipcardScreen extends StatefulWidget {
  final List<Word> words;
  final int wordIndex;
  const WordsFlipcardScreen(
      {super.key, required this.words, required this.wordIndex});

  @override
  State<WordsFlipcardScreen> createState() => _WordsFlipcardScreenState();
}

class _WordsFlipcardScreenState extends State<WordsFlipcardScreen> {
  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: widget.wordIndex);
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: controller,
        children: widget.words
            .map((word) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: WordFlipCardWidget(word: word),
                ))
            .toList(),
      ),
    );
  }
}
