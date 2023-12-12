import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/word.dart';

@freezed
class WordLesson {
  final String name;
  final String description;
  final int id;
  final List<Word> words;

  WordLesson(this.name, this.description, this.words, this.id);

  WordLesson.fromMap(MapBase data, this.id)
      : name = data['name'],
        description = data['description'],
        words =
            List<Word>.from(data['words'].map((entry) => Word.fromMap(entry)));
}
