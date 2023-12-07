import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/example.dart';

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
  final List<Example>? examples;

  Word(
      {this.gender,
      this.examples,
      required this.plurality,
      required this.arabic,
      required this.meaning,
      required this.id});

  Word.fromMap(MapBase data, this.id)
      : arabic = data['arabic'],
        meaning = data['meaning'],
        plurality = pluralityMap[data['plurality']]!,
        gender = genderMap[data['gender']],
        examples = List<Example>.from((data['examples'] ?? [])
            .map((example) => Example.fromMap(example)));
}
