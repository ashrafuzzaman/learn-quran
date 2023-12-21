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
      required List<Word> answerBankWords,
      int numberOfChoices = 4}) {
    if (answerBankWords.length < numberOfChoices) {
      throw Exception(
          "Answer bank words must be greater than or equal to number of choices");
    }
    List<MCQOption> options = [
      MCQOption(title: TextData(text: word.meaning), isCorrect: true)
    ];

    while (options.length < numberOfChoices) {
      int index = _getRandomNumber(answerBankWords.length - 1);
      final selectedWord = answerBankWords[index];
      if (options.any((option) => option.title.text == selectedWord.meaning)) {
        continue;
      }
      options.add(MCQOption(
          title: TextData(text: answerBankWords[index].meaning),
          isCorrect: false));
    }
    options.shuffle();

    return MultiChoiceQuestion(
        word: word,
        title: TextData(text: word.arabic, isArabic: true),
        options: options);
  }
}
