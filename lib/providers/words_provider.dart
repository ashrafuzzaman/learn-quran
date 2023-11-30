import 'package:flutter/services.dart';
import 'package:learnquran/dto/word.dart';
import 'package:yaml/yaml.dart';

Future<List<Word>> wordsProvider() async {
  final yamlString = await rootBundle.loadString('assets/data/words-en.yaml');
  final wordsData = loadYaml(yamlString)['words'];
  return List<Word>.from(wordsData.map((word) => Word(arabic: word['ar'], meaning: word['meaning'])));
}
