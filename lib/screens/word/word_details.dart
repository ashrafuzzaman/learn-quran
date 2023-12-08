import 'package:flutter/material.dart';
import 'package:learnquran/dto/example.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_helper.dart';
import 'package:learnquran/widgets/quick_font_selector.dart';
import 'package:learnquran/widgets/text/arabic_text.dart';
import 'package:learnquran/widgets/word/word_icon.dart';

class WordDetails extends StatelessWidget {
  final Word word;
  const WordDetails({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            QuickFontSelector(),
          ],
        ),
      ),
      backgroundColor: getWordBackgroundColor(context, word),
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
              Text(
                word.meaning,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32),
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
                ExamplesWidget(examples: word.examples),
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

  const ExamplesWidget({super.key, this.examples});

  @override
  Widget build(BuildContext context) {
    if (examples!.isEmpty) return const SizedBox.shrink();

    return Column(
        children: examples!
            .map((example) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ArabicText(
                        example.arabic,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      example.meaning,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ))
            .toList());
  }
}
