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

  log.info("Loading examples...");

  // import examples
  var examples = await WordExampleCSVRepo().getExamples();
  var exampleRepo = ExamplesRepo();

  for (var example in examples) {
    // log.info(
    //     "${example.word}:${example.ayahRef}\n${example.arabic}\n${example.meaning}");
    await exampleRepo.sync(example);
  }
}
