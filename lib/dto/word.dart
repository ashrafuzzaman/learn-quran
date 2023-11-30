import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Word {
  final String arabic;
  final String meaning;

  Word({required this.arabic, required this.meaning});
}
