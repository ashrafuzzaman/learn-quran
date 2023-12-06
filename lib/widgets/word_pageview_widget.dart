import 'package:flutter/material.dart';
import 'package:learnquran/widgets/word/word_flipcard.dart';
import 'package:learnquran/dto/word.dart';

class WordPageviewWidget extends StatefulWidget {
  final List<Word> words;
  final int wordIndex;
  const WordPageviewWidget(this.words, this.wordIndex, {super.key});

  @override
  State<WordPageviewWidget> createState() => _WordPageviewWidgetState();
}

class _WordPageviewWidgetState extends State<WordPageviewWidget> {
  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: widget.wordIndex);
    return PageView(
      controller: controller,
      children: widget.words
          .map((word) => Padding(
                padding: const EdgeInsets.all(5),
                child: WordFlipCard(word: word),
              ))
          .toList(),
    );
  }
}
