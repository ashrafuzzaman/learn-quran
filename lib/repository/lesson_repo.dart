import 'package:learnquran/dto/lesson.dart';
import 'package:learnquran/service/database.dart';
import 'package:logging/logging.dart';

const String tableLesson = 'lessons';
const String columnId = 'id';
const String columnName = 'name';
const String columnDescription = 'description';
const String columnTotalWords = 'totalWords';
const String columnWordsLearned = 'wordsLearned';

class LessonRepo extends DbService {
  final log = Logger('LessonRepo');

  Future<Lesson?> getByName(String name) async {
    var record = await query(tableLesson, where: 'name = ?', whereArgs: [name]);
    if (record.isNotEmpty) {
      return Lesson(
          int.parse(record.first[columnId].toString()),
          record.first[columnName].toString(),
          record.first[columnDescription].toString());
    }
    return null;
  }

  sync(String name, String description, int totalWords) async {
    var lesson = await getByName(name);
    if (lesson == null) {
      await insert(tableLesson, {
        columnName: name,
        columnDescription: description,
        columnTotalWords: totalWords,
        columnWordsLearned: 0,
      });
    }
  }
}
