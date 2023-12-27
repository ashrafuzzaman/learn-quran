import 'dart:ui';

import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/lesson.dart';
import 'package:learnquran/repository/lesson_repo.dart';
import 'package:learnquran/repository/word_lesson_file_repo.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:logging/logging.dart';

final log = Logger('LoadDatabase');

initializeWordsDatabase(Locale local) async {
  log.info("Loading data into database");
  var lessonRepo = LessonRepo();
  var wordRepo = WordRepo();
  var lessons = await WordLessonFileRepo().getLessons(local);
  for (var lesson in lessons) {
    log.info("Syncing lesson: ${lesson.name}");

    await lessonRepo.sync(lesson.name, lesson.description, lesson.words.length);
    Lesson? savedLesson = await lessonRepo.getByName(lesson.name);
    log.info("Saved lesson: ${savedLesson!.id}");
    for (Word word in lesson.words) {
      log.info("Syncing words: ${word.arabic}");
      await wordRepo.sync(savedLesson.id, word);
    }
  }
}
