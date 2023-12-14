import 'dart:collection';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

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
  final String id;
  final String arabic;
  final String meaning;
  final Gender? gender;
  final Plurality? plurality;
  final List<Example>? examples;

  Word(
      {this.gender,
      this.examples,
      required this.plurality,
      required this.arabic,
      required this.meaning,
      required this.id});

  Word.fromMap(MapBase data)
      : id = Word.generateId(data['arabic'], data['plurality']),
        arabic = data['arabic'],
        meaning = data['meaning'],
        plurality = pluralityMap[data['plurality']],
        gender = genderMap[data['gender']],
        examples = List<Example>.from((data['examples'] ?? [])
            .map((example) => Example.fromMap(example)));

  static String generateId(String arabic, String? plurality) {
    var key = arabic;
    if (plurality != null) {
      key = key + plurality;
    }
    var content = const Utf8Encoder().convert(key);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
