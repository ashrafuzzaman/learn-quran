import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';

class WordIterator implements Iterator<Word> {
  final List<Word> _words = [];
  var _index = 0;

  WordIterator(List<WordLesson> lessons, String? startWordId) {
    for (var lesson in lessons) {
      _words.addAll(lesson.words);
    }

    if (startWordId != null) {
      var index = _words.indexWhere((word) => word.id == startWordId);
      if (index != -1) {
        _index = index;
      }
    }
  }

  get words => _words;

  @override
  Word get current => _words[_index++];
  @override
  bool moveNext() => _index < _words.length;
}
