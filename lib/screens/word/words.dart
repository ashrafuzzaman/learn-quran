import 'package:flutter/material.dart';
import 'package:learnquran/screens/word/words_flipcard_screen.dart';
import 'package:learnquran/widgets/quick_font_selector.dart';
import 'package:learnquran/widgets/word_list_widget.dart';
import 'package:learnquran/dto/word.dart';

class WordListPage extends StatelessWidget {
  final String title;
  final List<Word> words;

  const WordListPage({super.key, required this.title, required this.words});

  void _switchToFlipCardView(BuildContext context, int wordId) {
    final wordIndex = words.indexWhere((word) => word.id == wordId);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WordsFlipcardScreen(
                words: words,
                wordIndex: wordIndex,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const QuickFontSelector()
          ],
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: WordListWidget(words, (int wordId) {
        _switchToFlipCardView(context, wordId);
      }),
    );
  }
}
