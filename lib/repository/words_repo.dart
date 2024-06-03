import 'dart:collection';

import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/lesson_repo.dart';
import 'package:learnquran/repository/repo_base.dart';
import 'package:logging/logging.dart';

const String tableWords = 'words';
const String columnId = 'id';
const String columnLessonId = 'lessonId';
const String columnArabic = 'arabic';
const String columnMeaning = 'meaning';
const String columnPlurality = 'plurality';
const String columnGender = 'gender';
const String columnLearned = 'learned';
const String columnLearnLevel = 'learnLevel';
const String columnRead = 'read';
const String columnTotalExamples = 'totalExamples';
const String columnLastCorrectedAt = 'lastCorrectedAt';

const Map<Plurality, String> pluralityMap = {
  Plurality.singular: 's',
  Plurality.dual: 'd',
  Plurality.plural: 'p',
};

const Map<Gender, String> genderMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

class WordRepo extends RepoBase {
  @override
  final log = Logger('WordRepo');

  Future<List<Word>> findWordsByIds(List<int> wordIds) async {
    var records = await query(tableWords,
        where: '$columnId IN (?)',
        whereArgs: [wordIds.map((id) => id.toString()).toList().join(',')]);
    return records.map((record) => recordToWord(record)).toList();
  }

  Future<Word?> findWordByArabic(String arabic) async {
    var records = await query(tableWords,
        where: '$columnArabic = ?', whereArgs: [arabic]);
    return records.map((record) => recordToWord(record)).toList().first;
  }

  Future<Word?> findWordById(int wordId) async {
    var result =
        await query(tableWords, where: '$columnId = ?', whereArgs: [wordId]);
    if (result.isNotEmpty) {
      return recordToWord(result.first);
    }
    return null;
  }

  sync(Word word) async {
    var dbWord = await findWordById(word.id);
    if (dbWord == null) {
      await insert(tableWords, {
        columnId: word.id,
        columnLessonId: word.lessonId,
        columnArabic: word.arabic,
        columnMeaning: word.meaning,
        columnPlurality: pluralityMap[word.plurality],
        columnGender: genderMap[word.gender],
      });
    }
  }

  updateWord(int wordId, values) async {
    await update(tableWords, values,
        where: '$columnId = ?', whereArgs: [wordId]);
  }

  markLearned(int wordId) async {
    await updateWord(wordId, {
      columnLearned: true,
    });

    var word = await findWordById(wordId);
    // update lesson count
    int wordsLearned = await getWordLearnedByLessonId(word!.lessonId);
    var lessonRepo = LessonRepo();
    lessonRepo.updateWordsLearned(word.lessonId, wordsLearned);
  }

  markRead(int wordId) async {
    await updateWord(wordId, {
      columnRead: true,
    });
  }

  touchLastCorrectedAt(int wordId) async {
    await updateWord(wordId, {
      columnLastCorrectedAt: "DATETIME('now')",
    });
  }

  updateTotalExamples(int wordId, int totalExamples) async {
    await updateWord(wordId, {
      columnTotalExamples: totalExamples,
    });
  }

  Future<List<Word>> getAllWords(int limit) async {
    var records =
        await query(tableWords, orderBy: '$columnId ASC', limit: limit);
    return records.map((record) => recordToWord(record)).toList();
  }

  Future<List<Word>> getWordsToLearn(int limit) async {
    var records = await query(tableWords,
        where: """
          $columnLearned = ? AND
          ($columnLastCorrectedAt is NULL
            OR $columnLastCorrectedAt < DATETIME('now', '-5 minutes'))
        """,
        whereArgs: [false],
        orderBy: '$columnId ASC, $columnRead DESC',
        limit: limit);
    return records.map((record) => recordToWord(record)).toList();
  }

  Future<List<Word>> getWordsRead() async {
    var records = await query(tableWords,
        where: '$columnRead = ?', whereArgs: [true], orderBy: '$columnId ASC');
    return records.map((record) => recordToWord(record)).toList();
  }

  Future<bool> isWordRead(int wordId) async {
    var record = await query(tableWords,
        where: '$columnId = ? AND $columnRead', whereArgs: [wordId, true]);
    return record.isNotEmpty;
  }

  getWordCountByLesson() async {
    var records = await query(
      tableWords,
      columns: ['lessonId', 'COUNT(*) as count'],
      groupBy: 'lessonId',
    );
    return records;
  }

  Future<int> getWordLearnedByLessonId(int lessonId) async {
    var records = await query(
      tableWords,
      columns: ['COUNT(*) as count'],
      where: '$columnLessonId = ? AND $columnLearned = ?',
      whereArgs: [lessonId, true],
      groupBy: 'lessonId',
    );
    return records.first['count'] as int;
  }

  Word recordToWord(Map<String, Object?> record) {
    return Word.fromMap({
      'id': record[columnId],
      'lessonId': record[columnLessonId],
      'arabic': record[columnArabic],
      'meaning': record[columnMeaning],
      'plurality': record[columnPlurality],
      'learned': record[columnLearned] == 1,
      'totalExamples': record[columnTotalExamples],
      'gender': record[columnGender],
    } as MapBase);
  }
}
