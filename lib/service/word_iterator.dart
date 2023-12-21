import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';

class WordIterator implements Iterator<Word> {
  final List<Word> _words = [];

  WordIterator(List<WordLesson> lessons) {
    for (var lesson in lessons) {
      _words.addAll(lesson.words);
    }
  }

  get words => _words;

  var _index = 0;
  @override
  Word get current => _words[_index++];
  @override
  bool moveNext() => _index < _words.length;
}
