import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/lesson_repo.dart';
import 'package:learnquran/repository/word_lesson_csv_repo.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:logging/logging.dart';

final log = Logger('LoadDatabase');

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
    // log.info(
    // "Loading word: ${word.arabic}/${word.meaning}/${word.plurality}/${word.gender}");
    await wordRepo.sync(word);
  }
}
