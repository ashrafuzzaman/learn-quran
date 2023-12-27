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
}
