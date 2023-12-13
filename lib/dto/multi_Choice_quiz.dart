import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/quiz_option.dart';
import 'package:learnquran/dto/text_data.dart';
import 'package:learnquran/dto/word.dart';

@freezed
class MultiChoiceQuiz {
  final Word word;
  final TextData title;
  final List<QuizOption> options;

  MultiChoiceQuiz(
      {required this.word, required this.title, required this.options});
}
