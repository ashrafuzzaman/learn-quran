import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/examples_repo.dart';
import 'package:learnquran/repository/lesson_repo.dart';
import 'package:learnquran/repository/word_csv_repo.dart';
import 'package:learnquran/repository/word_example_csv_repo.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:logging/logging.dart';

final log = Logger('LoadDatabase');

initializeWordsDatabaseFromCsv() async {
  log.info("Loading data into database");
  var lessonRepo = LessonRepo();
  var wordRepo = WordRepo();
  var words = await WordCSVRepo().getWords();
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

  var wordCountByLesson = await wordRepo.getWordCountByLesson();
  log.info("wordCountByLesson :: ${wordCountByLesson.length}");
  for (var record in wordCountByLesson) {
    log.info("${record['lessonId']}, ${record['count']}");
    await lessonRepo.updateTotalWords(
        record['lessonId'] as int, record['count'] as int);
  }

  log.info("Loading examples...");

  // import examples
  var examples = await WordExampleCSVRepo().getExamples();
  var exampleRepo = ExamplesRepo();

  log.info("examples.length: ${examples.length}");
  for (var example in examples) {
    // log.info("${example.wordId}|${example.ayahRef}");
    try {
      await exampleRepo.sync(example);
    } on Exception catch (e) {
      log.warning("Error while loading example: ${e.toString()}");
    }
  }

  var exampleCountByWords = await exampleRepo.getExampleCountByWord();
  // log.info("exampleCountByWords :: ${exampleCountByWords.length}");
  for (var record in exampleCountByWords) {
    // log.info("${record['wordId']}, ${record['count']}");
    await wordRepo.updateTotalExamples(
        record['wordId'] as int, record['count'] as int);
  }
}
