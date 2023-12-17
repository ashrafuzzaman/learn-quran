import 'dart:math';
import 'package:learnquran/dto/multi_Choice_question.dart';
import 'package:learnquran/dto/mcq_option.dart';
import 'package:learnquran/dto/text_data.dart';
import 'package:learnquran/dto/word.dart';

class RandomMCQGenerator {
  _getRandomNumber(int max) {
    return Random().nextInt(max) + 1;
  }

  MultiChoiceQuestion getQuestion(
      {required Word word,
      required List<Word> words,
      int numberOfChoices = 4}) {
    List<MCQOption> options = [
      MCQOption(title: TextData(text: word.meaning), isCorrect: true)
    ];

    while (options.length < numberOfChoices) {
      int index = _getRandomNumber(words.length - 1);
      final selectedWord = words[index];
      if (options.any((option) => option.title.text == selectedWord.meaning)) {
        continue;
      }
      options.add(MCQOption(
          title: TextData(text: words[index].meaning), isCorrect: false));
    }
    options.shuffle();

    return MultiChoiceQuestion(
        word: word,
        title: TextData(text: word.arabic, isArabic: true),
        options: options);
  }
}
