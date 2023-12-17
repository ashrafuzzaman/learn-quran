import 'package:flutter/material.dart';
import 'package:learnquran/dto/example.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_helper.dart';
import 'package:learnquran/widgets/quick_font_selector.dart';
import 'package:learnquran/widgets/text/arabic_highlighted_text.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';
import 'package:learnquran/widgets/word/word_icon.dart';
import 'package:dartarabic/dartarabic.dart';
import 'package:highlight_text/highlight_text.dart';

class WordDetails extends StatelessWidget {
  final Word word;
  const WordDetails({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    var bgColor = getWordBackgroundColor(context, word);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            QuickFontSelector(),
          ],
        ),
      ),
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ArabicText(
            word.arabic,
            fontSize: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Hero(
                tag: 'meaning:${word.id}',
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
                child: Text(
                  word.meaning,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              SizedBox(child: WordIcon(word: word))
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            height: 30,
            endIndent: 30,
            indent: 30,
            thickness: .5,
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                ExamplesWidget(
                    originalWord: word.arabic, examples: word.examples),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExamplesWidget extends StatelessWidget {
  final List<Example>? examples;
  final String originalWord;

  const ExamplesWidget({super.key, required this.originalWord, this.examples});

  @override
  Widget build(BuildContext context) {
    if (examples!.isEmpty) return const SizedBox.shrink();

    return Column(
        children: examples!
            .map((example) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ArabicHighlightedText(
                        originalWord,
                        example.arabic,
                        textAlign: TextAlign.center,
                        fontSize: 32,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        example.meaning,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ))
            .toList());
  }
}
