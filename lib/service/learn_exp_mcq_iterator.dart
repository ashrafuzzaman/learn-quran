import 'package:learnquran/dto/word.dart';
import 'package:learnquran/service/learning_experience_wizard.dart';

class LearnExpMCQIterator implements Iterator<LearnExperience> {
  final List<Word> _words;
  final List<Word> _answerBankWords;
  final List<MCQWordExperience> mcqWordExperiences = [];
  int _index = 0;

  LearnExpMCQIterator(
      {required List<Word> words, required List<Word> answerBankWords})
      : _words = words,
        _answerBankWords = answerBankWords;

  @override
  bool moveNext() => _index < _words.length;

  @override
  LearnExperience get current => _getNextExperience();

  LearnExperience _getNextExperience() {
    var mcqWordExperience = MCQWordExperience(
        word: _words[_index++], answerBankWords: _answerBankWords);
    mcqWordExperiences.add(mcqWordExperience);
    return mcqWordExperience;
  }

  bool isAllCorrect() {
    return mcqWordExperiences.every((mcqWordExperience) =>
        mcqWordExperience.isCorrect == true ||
        mcqWordExperience.isCorrect != null);
  }
}
