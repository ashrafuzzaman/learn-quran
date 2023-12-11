import 'dart:math';
import 'package:learnquran/dto/multi_Choice_quiz.dart';
import 'package:learnquran/dto/quiz_option.dart';
import 'package:learnquran/dto/text_data.dart';
import 'package:learnquran/dto/word.dart';

class RandomMultiChoiceQuizGenerator {
  _getRandomNumber(int max) {
    return Random().nextInt(max) + 1;
  }

  MultiChoiceQuiz getQuiz(
      {required Word word,
      required List<Word> words,
      int numberOfChoices = 4}) {
    List<QuizOption> options = [
      QuizOption(title: TextData(text: word.meaning), isCorrect: true)
    ];

    while (options.length < numberOfChoices) {
      int index = _getRandomNumber(words.length - 1);
      final selectedWord = words[index];
      if (options.any((option) => option.title.text == selectedWord.meaning)) {
        continue;
      }
      options.add(QuizOption(
          title: TextData(text: words[index].meaning), isCorrect: false));
    }
    options.shuffle();

    return MultiChoiceQuiz(
        title: TextData(text: word.arabic, isArabic: true), options: options);
  }
}
