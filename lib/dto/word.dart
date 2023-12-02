import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Word {
  final int sequence;
  final String arabic;
  final String meaning;

  Word({required this.arabic, required this.meaning, required this.sequence});

  Word.fromMap(MapBase data, this.sequence)
      : arabic = data['arabic'],
        meaning = data['meaning'];
}
