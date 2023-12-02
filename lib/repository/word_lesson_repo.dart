import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:yaml/yaml.dart';

class WordLessonRepo {
  Future<List<WordLesson>> getLessons(Locale local) async {
    String yamlString;
    try {
      var corpusPath = "assets/data/word-lesson-${local.languageCode}.yaml";
      yamlString = await rootBundle.loadString(corpusPath);
    } on Exception {
      throw Exception("Language not supported");
    }
    final data = loadYaml(yamlString);
    return List<WordLesson>.from(data['lessons'].map((lesson) => WordLesson.fromMap(lesson)));
  }
}
