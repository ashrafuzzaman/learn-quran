import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Example {
  final int wordId;
  final String arabic;
  final String meaning;
  String? highlight;
  String ayahRef;

  Example({
    required this.wordId,
    required this.arabic,
    required this.meaning,
    required this.ayahRef,
    this.highlight,
  });
}
