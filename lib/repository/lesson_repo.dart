import 'package:learnquran/dto/lesson.dart';
import 'package:learnquran/repository/repo_base.dart';
import 'package:logging/logging.dart';

const String tableLesson = 'lessons';
const String columnId = 'id';
const String columnName = 'name';
const String columnDescription = 'description';
const String columnTotalWords = 'totalWords';
const String columnWordsLearned = 'wordsLearned';

class LessonRepo extends RepoBase {
  @override
  final log = Logger('LessonRepo');

  Future<Lesson?> getByName(String name) async {
    var record =
        await query(tableLesson, where: '$columnName = ?', whereArgs: [name]);
    return record.isNotEmpty ? _recordToLesson(record) : null;
  }

  Future<Lesson?> getById(int id) async {
    var record =
        await query(tableLesson, where: '$columnId = ?', whereArgs: [id]);
    return record.isNotEmpty ? _recordToLesson(record) : null;
  }

  Lesson _recordToLesson(List<Map<String, Object?>> record) {
    return Lesson(
        int.parse(record.first[columnId].toString()),
        record.first[columnName].toString(),
        record.first[columnDescription].toString());
  }

  sync(int id, String name, String description, int totalWords) async {
    var lesson = await getById(id);
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
