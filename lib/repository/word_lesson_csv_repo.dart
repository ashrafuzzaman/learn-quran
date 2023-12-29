
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:learnquran/dto/word.dart';

class WordLessonCSVRepo {
  Future<List<Word>> getWords() async {
    String wordsFileContent;
    try {
      var corpusPath = "assets/data/words.csv";
      wordsFileContent = await rootBundle.loadString(corpusPath);
    } on Exception {
      throw Exception("Language not supported");
    }
    final data = const CsvToListConverter().convert(wordsFileContent);
    var columLessonId = 1;
    var columId = 2;
    var columArabic = 3;
    var columMeaning = 4;
    return List<Word>.from(data.skip(1).map((entry) => Word(
        arabic: entry[columArabic],
        meaning: entry[columMeaning],
        lessonId: entry[columLessonId],
        id: entry[columId],
        plurality: null,
        gender: null)));
  }
}
