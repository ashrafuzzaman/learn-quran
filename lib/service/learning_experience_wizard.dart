import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/service/learn_exp_word.dart';
import 'package:learnquran/service/word_iterator.dart';
import 'package:logging/logging.dart';

class LearningExperienceWizard {
  final log = Logger('LearningExperienceWizard');

  WordIterator? wordIterator;
  List<Word> answerBankWords = [];

  int batchSize = 3;
  late LearnExpWordIterator learnExpWordIterator;
  late LearnExpMCQIterator learnExpMCQIterator;
  var wordRepo = WordRepo();

  Future<LearningExperienceWizard> initialize() async {
    List<Word> words = await wordRepo.getWordsToLearn(batchSize);

    if (answerBankWords.isEmpty) {
      answerBankWords = await wordRepo.getAllWords(30);
    }
    wordIterator = WordIterator(words);

    _generateExperiences();
    return this;
  }

  List<Word> _getNextWords(int numberOfWords) {
    var words = <Word>[];
    for (var i = 0; i < numberOfWords; i++) {
      if (wordIterator != null && wordIterator!.moveNext()) {
        words.add(wordIterator!.current);
      }
    }
    return words;
  }

  List<Word> _generateExperiences() {
    var nextWords = _getNextWords(batchSize);
    learnExpWordIterator = LearnExpWordIterator(nextWords);

    learnExpMCQIterator =
        LearnExpMCQIterator(words: nextWords, answerBankWords: answerBankWords);
    return nextWords;
  }

  bool hasNextExperience() =>
      learnExpWordIterator.moveNext() ||
      learnExpMCQIterator.moveNext() ||
      (wordIterator != null && wordIterator!.moveNext());

  Future<LearnExperience> getNextExperience() async {
    if (learnExpWordIterator.moveNext()) {
      return learnExpWordIterator.current;
    }
    if (learnExpMCQIterator.moveNext()) {
      return learnExpMCQIterator.current;
    }
    await initialize();
    return getNextExperience();
  }
}

class LearnExperience {
  final Word word;

  LearnExperience({required this.word});
}
