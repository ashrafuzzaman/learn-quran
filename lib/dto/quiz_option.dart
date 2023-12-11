import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/text_data.dart';

@freezed
class QuizOption {
  final TextData title;
  final bool isCorrect;

  QuizOption({required this.title, required this.isCorrect});
}
