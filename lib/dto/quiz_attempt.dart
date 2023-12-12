import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class QuizAttempt {
  final String text;
  final bool isArabic;

  QuizAttempt({required this.text, this.isArabic = false});
}
