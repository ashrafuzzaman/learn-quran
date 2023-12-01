import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/word.dart';

@freezed
class WordLesson {
  final String name;
  final String description;
  final List<Word> words;

  WordLesson(this.name, this.description, this.words);
}
