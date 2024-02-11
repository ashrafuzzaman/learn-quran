import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender { male, female }

enum Plurality { singular, dual, plural }

const Map<String, Plurality> pluralityMap = {
  's': Plurality.singular,
  'd': Plurality.dual,
  'p': Plurality.plural,
};

const Map<String, Gender> genderMap = {
  'male': Gender.male,
  'female': Gender.female,
};

@freezed
class Word {
  int id;
  int stageId;
  int lessonId;
  final String audioId;
  final String arabic;
  final String meaning;
  final Gender? gender;
  final Plurality? plurality;
  final bool? learned;
  final int totalExamples;

  Word(
      {this.gender,
      this.learned,
      required this.plurality,
      required this.arabic,
      required this.meaning,
      required this.lessonId,
      this.totalExamples = 0,
      required this.audioId,
      required this.stageId,
      required this.id});

  Word.fromMap(MapBase data)
      : arabic = data['arabic'],
        meaning = data['meaning'],
        learned = data['learned'] ?? false,
        id = data['id'],
        stageId = data['stageId'],
        audioId = data['audioId'],
        lessonId = data['lessonId'],
        plurality = pluralityMap[data['plurality']],
        totalExamples = data['totalExamples'] ?? 0,
        gender = genderMap[data['gender']];
}
