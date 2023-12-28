import 'package:learnquran/dto/word.dart';

class WordIterator implements Iterator<Word> {
  final List<Word> words;
  var _index = 0;

  WordIterator(this.words);

  @override
  Word get current => words[_index++];
  @override
  bool moveNext() => _index < words.length;
}
