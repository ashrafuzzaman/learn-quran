import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/text_data.dart';

@freezed
class MCQOption {
  final TextData title;
  final bool isCorrect;

  MCQOption({required this.title, required this.isCorrect});
}
