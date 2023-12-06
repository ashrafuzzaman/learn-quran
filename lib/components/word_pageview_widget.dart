import 'package:flutter/material.dart';
import 'package:learnquran/components/word/word_flipcard.dart';
import 'package:learnquran/dto/word.dart';

class WordPageviewWidget extends StatefulWidget {
  final List<Word> words;
  final int initialPage;
  const WordPageviewWidget(this.words, this.initialPage, {super.key});

  @override
  State<WordPageviewWidget> createState() => _WordPageviewWidgetState();
}

class _WordPageviewWidgetState extends State<WordPageviewWidget> {
  @override
  Widget build(BuildContext context) {
    print("widget.initialPage");
    print(widget.initialPage);
    final PageController controller =
        PageController(initialPage: widget.initialPage);
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
