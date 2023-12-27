import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/lesson.dart';
import 'package:yaml/yaml.dart';

class WordLessonFileRepo {
  Future<List<LessonWithWords>> getLessons(Locale local) async {
    String yamlString;
    List<String> splits;
    try {
      var corpusPath = "assets/data/word-lesson-${local.languageCode}.yaml";
      yamlString = await rootBundle.loadString(corpusPath);
      splits = yamlString.split(RegExp(r'-{3,}'));
    } on Exception {
      throw Exception("Language not supported");
    }
    final data = loadYaml(splits[splits.length - 1]);
    return List<LessonWithWords>.from(data['lessons']
        .asMap()
        .entries
        .map((entry) => LessonWithWords.fromMap(entry.value, entry.key)));
  }

  Word getWordFromLesson(String wordId, List<LessonWithWords> lessons) {
    for (var lesson in lessons) {
      for (var word in lesson.words) {
        if (word.id == wordId) return word;
      }
    }
    throw "Word not found";
  }
}