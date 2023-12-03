import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender { male, female }

enum Plurality { singular, dual, plural }

@freezed
class Word {
  final int sequence;
  final String arabic;
  final String meaning;
  final Gender? gender;
  final Plurality plurality;

  Word(this.gender,
      {required this.plurality,
      required this.arabic,
      required this.meaning,
      required this.sequence});

  Word.fromMap(MapBase data, this.sequence)
      : arabic = data['arabic'],
        meaning = data['meaning'],
        plurality = data['plurality'] == 's'
            ? Plurality.singular
            : (data['plurality'] == 'p' ? Plurality.plural : Plurality.dual),
        gender = data['gender'] == "male"
            ? Gender.male
            : (data['gender'] == "female" ? Gender.female : data['gender']);
}
