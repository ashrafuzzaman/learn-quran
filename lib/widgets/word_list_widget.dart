import 'package:flutter/material.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';
import 'package:learnquran/widgets/word/word_icon.dart';
import 'package:learnquran/dto/word.dart';

class WordListWidget extends StatelessWidget {
  final List<Word> words;
  final Function(String wordId) handleTap;

  const WordListWidget(this.words, this.handleTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListView(
        children: words
            .map((word) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: 'arabicText:${word.id}',
                            flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                            ) {
                              return DefaultTextStyle(
                                style: DefaultTextStyle.of(toHeroContext).style,
                                child: toHeroContext.widget,
                              );
                            },
                            child: ArabicText(
                              word.arabic,
                              fontSize: 32,
                            ),
                          ),
                          Row(
                            children: [
                              Text(word.meaning,
                                  style: const TextStyle(fontSize: 20)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: WordIcon(word: word),
                              )
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        handleTap(word.id);
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
