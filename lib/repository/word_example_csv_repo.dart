import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class WordExampleCSVRepo {
  Future<List<ExampleFromCsv>> getExamples() async {
    String wordsFileContent;
    try {
      var corpusPath = "assets/data/examples.csv";
      wordsFileContent = await rootBundle.loadString(corpusPath);
    } on Exception {
      throw Exception("Example not found");
    }
    final data =
        const CsvToListConverter().convert(wordsFileContent, eol: "\n");
    var index = 0;
    var columAyaRef = index++;
    var columArabic = index++;
    var columMeaning = index++;
    var columHighlight = index++;

    var currentWord = "";
    List<ExampleFromCsv> examples = [];

    data.skip(1).forEach((entry) {
      if (entry[columAyaRef].toString().isEmpty) {
        currentWord = entry[columArabic];
        return;
      }

      examples.add(ExampleFromCsv(
        word: currentWord,
        arabic: entry[columArabic],
        meaning: entry[columMeaning],
        ayahRef: entry[columAyaRef],
        highlight: entry[columHighlight],
      ));
    });
    return examples;
  }
}

@freezed
class ExampleFromCsv {
  final String word;
  final String arabic;
  final String meaning;
  final String ayahRef;
  String? highlight;

  ExampleFromCsv({
    required this.word,
    required this.arabic,
    required this.meaning,
    required this.ayahRef,
    this.highlight,
  });
}
