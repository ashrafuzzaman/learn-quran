import 'dart:ui';

import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/lesson.dart';
import 'package:learnquran/repository/lesson_repo.dart';
import 'package:learnquran/repository/word_lesson_csv_repo.dart';
import 'package:learnquran/repository/word_lesson_file_repo.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:logging/logging.dart';

final log = Logger('LoadDatabase');

initializeWordsDatabaseFromYaml(Locale local) async {
  log.info("Loading data into database");
  var lessonRepo = LessonRepo();
  var wordRepo = WordRepo();
  var lessons = await WordLessonFileRepo().getLessons(local);
  for (var lesson in lessons) {
    await lessonRepo.sync(
        lesson.id, lesson.name, lesson.description, lesson.words.length);
    Lesson? savedLesson = await lessonRepo.getByName(lesson.name);
    for (Word word in lesson.words) {
      word.lessonId = savedLesson!.id;
      await wordRepo.sync(word);
    }
  }
}

initializeWordsDatabaseFromCsv() async {
  log.info("Loading data into database");
  var lessonRepo = LessonRepo();
  var wordRepo = WordRepo();
  var words = await WordLessonCSVRepo().getWords();
  // clean database
  // await lessonRepo.drop();
  int lessonId = 0;
  for (Word word in words) {
    if (lessonId != word.lessonId) {
      lessonId = word.lessonId;
      await lessonRepo.sync(
          lessonId, 'Lesson: $lessonId', 'Lesson: $lessonId', 1);
    }
    await wordRepo.sync(word);
  }
}
