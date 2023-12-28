import 'dart:collection';

import 'package:learnquran/dto/word.dart';
import 'package:learnquran/service/database.dart';
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

const Map<Plurality, String> pluralityMap = {
  Plurality.singular: 's',
  Plurality.dual: 'd',
  Plurality.plural: 'p',
};

const Map<Gender, String> genderMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

class WordRepo extends DbService {
  final log = Logger('WordRepo');

  findWord(
      {required String arabic, Plurality? plurality, Gender? gender}) async {
    query(tableWords,
        where:
            '$columnArabic = ? AND $columnPlurality = ? AND $columnGender = ?',
        whereArgs: [arabic, pluralityMap[plurality], genderMap[gender]]);
  }

  sync(int lessonId, Word word) async {
    var dbWord = await findWord(
        arabic: word.arabic, plurality: word.plurality, gender: word.gender);
    if (dbWord == null) {
      await insert(tableWords, {
        columnLessonId: lessonId,
        columnArabic: word.arabic,
        columnMeaning: word.meaning,
        columnPlurality: pluralityMap[word.plurality],
        columnGender: genderMap[word.gender],
      });
    }
  }

  markLearned(int wordId) async {
    await update(
        tableWords,
        {
          columnLearned: true,
        },
        where: '$columnId = ?',
        whereArgs: [wordId]);
  }

  markRead(int wordId) async {
    await update(
        tableWords,
        {
          columnRead: true,
        },
        where: '$columnId = ?',
        whereArgs: [wordId]);
  }

  Future<List<Word>> getAllWords(int limit) async {
    var records =
        await query(tableWords, orderBy: '$columnId ASC', limit: limit);
    return records.map((record) => _recordToWord(record)).toList();
  }

  Future<List<Word>> getWordsToLearn(int limit) async {
    var records = await query(tableWords,
        where: '$columnLearned = ?',
        whereArgs: [false],
        orderBy: '$columnId ASC, $columnRead DESC',
        limit: limit);
    return records.map((record) => _recordToWord(record)).toList();
  }

  Future<List<Word>> getWordsRead() async {
    var records = await query(tableWords,
        where: '$columnRead = ?', whereArgs: [true], orderBy: '$columnId ASC');
    return records.map((record) => _recordToWord(record)).toList();
  }

  Future<bool> isWordRead(int wordId) async {
    var record = await query(tableWords,
        where: '$columnId = ? AND $columnRead', whereArgs: [wordId, true]);
    return record.isNotEmpty;
  }

  Word _recordToWord(Map<String, Object?> record) {
    return Word.fromMap({
      'id': record[columnId],
      'arabic': record[columnArabic],
      'meaning': record[columnMeaning],
      'plurality': record[columnPlurality],
      'gender': record[columnGender],
    } as MapBase);
  }
}
