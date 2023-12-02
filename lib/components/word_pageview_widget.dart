import 'package:flutter/material.dart';
import 'package:learnquran/components/word/word_flipcard.dart';
import 'package:learnquran/dto/word.dart';

class WordPageviewWidget extends StatefulWidget {
  final List<Word> words;
  const WordPageviewWidget(this.words, {super.key});

  @override
  State<WordPageviewWidget> createState() => _WordPageviewWidgetState();
}

class _WordPageviewWidgetState extends State<WordPageviewWidget> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: widget.words
          .map((word) => Padding(
                padding: const EdgeInsets.all(5),
                child: WordFlipCard(word),
              ))
          .toList(),
    );
  }
}
