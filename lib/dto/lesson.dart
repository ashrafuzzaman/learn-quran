import 'dart:collection';

import 'package:learnquran/dto/word.dart';

class Lesson {
  String name;
  String description;
  int id;

  Lesson(this.id, this.name, this.description);
}

class LessonWithWords extends Lesson {
  late List<Word> words;

  LessonWithWords(super.id, super.name, super.description, this.words);

  LessonWithWords.fromMap(MapBase data, int id)
      : super(id, data['name'], data['description']) {
    words = List<Word>.from(data['words'].map((entry) => Word.fromMap(entry)));
  }
}
