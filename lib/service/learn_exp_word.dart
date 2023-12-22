import 'package:learnquran/dto/word.dart';
import 'package:learnquran/service/learning_experience_wizard.dart';

class LearnExpWordIterator implements Iterator<LearnExperience> {
  late List<Word> words;
  int _index = 0;

  LearnExpWordIterator(this.words);

  @override
  bool moveNext() => _index < words.length;

  @override
  LearnExperience get current => _getNextExperience();

  LearnExperience _getNextExperience() {
    return LearnWordExperience(word: words[_index++]);
  }
}

class LearnWordExperience extends LearnExperience {
  LearnWordExperience({required super.word});
}
