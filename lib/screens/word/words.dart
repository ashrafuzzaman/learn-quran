import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquran/screens/word/words_flipcard_screen.dart';
import 'package:learnquran/widgets/quick_font_selector.dart';
import 'package:learnquran/widgets/word_list_widget.dart';
import 'package:learnquran/dto/word.dart';

class WordListPage extends StatelessWidget {
  final String title;
  final String emptyTitle;
  final List<Word> words;
  final Tab mainTab;

  const WordListPage(
      {super.key,
      required this.title,
      required this.emptyTitle,
      required this.mainTab,
      required this.words});

  void _switchToFlipCardView(BuildContext context, int wordId) {
    final wordIndex = words.indexWhere((word) => word.id == wordId);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WordsFlipCardScreen(
                words: words,
                wordIndex: wordIndex,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    WordListWidget getWordListWidget(Iterable<Word> words) {
      return WordListWidget(words.toList(), (int wordId) {
        _switchToFlipCardView(context, wordId);
      });
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const QuickFontSelector()
              ],
            ),
            centerTitle: true,
            elevation: 3,
            bottom: TabBar(
              tabs: [
                mainTab,
                const Tab(
                    icon: FaIcon(FontAwesomeIcons.glasses), text: "Need focus"),
                const Tab(
                    icon: FaIcon(FontAwesomeIcons.graduationCap),
                    text: "Learned"),
              ],
            ),
          ),
          body: words.isEmpty
              ? Center(
                  child: Text(
                  emptyTitle,
                  style: const TextStyle(fontSize: 32),
                ))
              : TabBarView(
                  children: [
                    getWordListWidget(words),
                    getWordListWidget(
                        words.where((word) => !(word.learned ?? false))),
                    getWordListWidget(
                        words.where((word) => word.learned ?? false)),
                  ],
                )),
    );
  }
}
