import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/word.dart';

@freezed
class WordLesson {
  final String name;
  final String description;
  final int sequence;
  final List<Word> words;

  WordLesson(this.name, this.description, this.words, this.sequence);

  WordLesson.fromMap(MapBase data, this.sequence)
      : name = data['name'],
        description = data['description'],
        words = List<Word>.from(
            data['words'].asMap().entries.map((entry) => Word.fromMap(entry.value, entry.key)));
}
