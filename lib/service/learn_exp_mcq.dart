import 'package:learnquran/dto/multi_Choice_question.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/mcq_attempt_repo.dart';
import 'package:learnquran/service/learning_experience_wizard.dart';
import 'package:learnquran/service/random_mcq_generator.dart';

class LearnExpMCQIterator implements Iterator<LearnExperience> {
  final List<Word> _words;
  final List<Word> _answerBankWords;
  final List<MCQWordExperience> mcqWordExperiences = [];
  int _index = 0;

  LearnExpMCQIterator(
      {required List<Word> words, required List<Word> answerBankWords})
      : _words = _shuffleWords(words),
        _answerBankWords = answerBankWords;

  static List<Word> _shuffleWords(List<Word> words) {
    var shuffledWords = List<Word>.from(words);
    shuffledWords.shuffle();
    return shuffledWords;
  }

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

class MCQWordExperience extends LearnExperience {
  List<Word> answerBankWords;
  late MultiChoiceQuestion question;
  bool? isCorrect;
  MCQWordExperience({required super.word, required this.answerBankWords});

  getMCQ() {
    var questionGenerator = RandomMCQGenerator();
    question = questionGenerator.getQuestion(
        word: word, answerBankWords: answerBankWords);
    return question;
  }

  recordAttempt(bool isCorrect) async {
    await MCQAttemptRepo().recordAttempt(word.id!, isCorrect);
    this.isCorrect = isCorrect;
  }
}
