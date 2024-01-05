import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/widgets/word/word_flipcard.dart';

class WordsFlipCardScreen extends StatefulWidget {
  final List<Word> words;
  final int wordIndex;
  const WordsFlipCardScreen(
      {super.key, required this.words, required this.wordIndex});

  @override
  State<WordsFlipCardScreen> createState() => _WordsFlipCardScreenState();
}

class _WordsFlipCardScreenState extends State<WordsFlipCardScreen> {
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
