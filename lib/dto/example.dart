import 'dart:collection';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Example {
  final String arabic;
  final String meaning;

  Example({required this.arabic, required this.meaning});

  Example.fromMap(MapBase data)
      : arabic = data['arabic'],
        meaning = data['meaning'];
}
