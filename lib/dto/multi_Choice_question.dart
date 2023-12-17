import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/mcq_option.dart';
import 'package:learnquran/dto/text_data.dart';
import 'package:learnquran/dto/word.dart';

@freezed
class MultiChoiceQuestion {
  final Word word;
  final TextData title;
  final List<MCQOption> options;

  MultiChoiceQuestion(
      {required this.word, required this.title, required this.options});
}
