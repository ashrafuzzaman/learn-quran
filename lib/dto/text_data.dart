import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class TextData {
  final String text;
  final bool isArabic;

  TextData({required this.text, this.isArabic = false});
}
