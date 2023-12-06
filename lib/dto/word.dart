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
  final int id;
  final String arabic;
  final String meaning;
  final Gender? gender;
  final Plurality plurality;

  Word(this.gender,
      {required this.plurality,
      required this.arabic,
      required this.meaning,
      required this.id});

  Word.fromMap(MapBase data, this.id)
      : arabic = data['arabic'],
        meaning = data['meaning'],
        plurality = data['plurality'] == 's'
            ? Plurality.singular
            : (data['plurality'] == 'p' ? Plurality.plural : Plurality.dual),
        gender = data['gender'] == "male"
            ? Gender.male
            : (data['gender'] == "female" ? Gender.female : data['gender']);
}
