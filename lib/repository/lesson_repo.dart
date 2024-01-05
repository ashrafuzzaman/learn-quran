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

  Future<Lesson?> findByName(String name) async {
    var record =
        await query(tableLesson, where: '$columnName = ?', whereArgs: [name]);
    return record.isNotEmpty ? _recordToLesson(record.first) : null;
  }

  Future<Lesson?> findById(int id) async {
    var record =
        await query(tableLesson, where: '$columnId = ?', whereArgs: [id]);
    return record.isNotEmpty ? _recordToLesson(record.first) : null;
  }

  Future<List<Lesson>> findAll() async {
    var record = await query(tableLesson);
    return record.isNotEmpty
        ? record.map((row) => _recordToLesson(row)).toList()
        : [];
  }

  updateWordsLearned(int id, int wordsLearned) async {
    await update(tableLesson, {columnWordsLearned: wordsLearned},
        where: '$columnId = ?', whereArgs: [id]);
  }

  Lesson _recordToLesson(Map<String, Object?> record) {
    return Lesson(
        id: int.parse(record[columnId].toString()),
        name: record[columnName].toString(),
        description: record[columnDescription].toString(),
        totalWords: int.parse(record[columnTotalWords].toString()),
        wordsLearned: int.parse(record[columnWordsLearned].toString()));
  }

  updateTotalWords(int id, int totalWords) async {
    await update(tableLesson, {columnTotalWords: totalWords},
        where: '$columnId = ?', whereArgs: [id]);
  }

  sync(int id, String name, String description, int totalWords) async {
    var lesson = await findById(id);
    if (lesson == null) {
      await insert(tableLesson, {
        columnName: name,
        columnDescription: description,
        columnTotalWords: totalWords,
        columnWordsLearned: 0,
      });
    } else {
      await update(
          tableLesson,
          {
            columnName: name,
            columnDescription: description,
            columnTotalWords: totalWords,
          },
          where: '$columnId = ?',
          whereArgs: [id]);
    }
  }
}
