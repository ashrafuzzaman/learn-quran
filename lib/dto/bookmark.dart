import 'dart:collection';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Bookmark {
  final int wordId;
  final bool isMarked;

  Bookmark({required this.wordId, required this.isMarked});

  Bookmark.fromMap(MapBase data)
      : wordId = data['wordId'],
        isMarked = data['isMarked'];
}
