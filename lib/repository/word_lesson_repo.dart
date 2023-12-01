import 'package:flutter/services.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:yaml/yaml.dart';

class WordLessonRepo {
  Future<List<WordLesson>> getLessons() async {
    final yamlString = await rootBundle.loadString('assets/data/word-lesson.yaml');
    final lessonsData = loadYaml(yamlString)['lessons'];
    return List<WordLesson>.from(lessonsData.map((lesson) => WordLesson(lesson['name'], lesson['description'],
        List<Word>.from(lesson['words'].map((word) => Word(arabic: word['arabic'], meaning: word['meaning']))))));
  }
}
