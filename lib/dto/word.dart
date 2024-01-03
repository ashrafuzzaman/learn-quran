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
  final String arabic;
  final String meaning;
  int lessonId;
  final Gender? gender;
  final Plurality? plurality;
  final bool? learned;

  Word(
      {this.gender,
      this.learned,
      required this.plurality,
      required this.arabic,
      required this.meaning,
      required this.lessonId,
      required this.id});

  Word.fromMap(MapBase data)
      : arabic = data['arabic'],
        meaning = data['meaning'],
        learned = data['learned'] ?? false,
        id = data['id'],
        lessonId = data['lessonId'],
        plurality = pluralityMap[data['plurality']],
        gender = genderMap[data['gender']];
}
