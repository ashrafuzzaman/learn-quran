import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:learnquran/dto/word.dart';

const Map<String, Plurality> pluralityMap = {
  'Singular': Plurality.singular,
  'Dual': Plurality.dual,
  'Plural': Plurality.plural,
};

const Map<String, Gender> genderMap = {
  'Male': Gender.male,
  'Female': Gender.female,
};

class WordCSVRepo {
  Future<List<Word>> getWords() async {
    String wordsFileContent;
    try {
      var corpusPath = "assets/data/words.csv";
      wordsFileContent = await rootBundle.loadString(corpusPath);
    } on Exception {
      throw Exception("Language not supported");
    }
    final data =
        const CsvToListConverter().convert(wordsFileContent, eol: "\n");
    var index = 0;
    var columId = index++;
    var columStageId = index++;
    var columLessonId = index++;
    var columAudioId = index++;
    var columGender = index++;
    var columNumber = index++;
    var columArabic = index++;
    var columMeaning = index++;
    return List<Word>.from(data.skip(1).map((entry) => Word(
        arabic: entry[columArabic].toString().trim(),
        meaning: entry[columMeaning].toString().trim(),
        lessonId: entry[columLessonId],
        id: entry[columId],
        stageId: entry[columStageId],
        audioId: entry[columAudioId].toString().trim(),
        plurality: pluralityMap[entry[columNumber].toString().trim()],
        gender: genderMap[entry[columGender].toString().trim()])));
  }
}
