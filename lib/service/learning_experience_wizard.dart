import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/service/learn_exp_word.dart';
import 'package:learnquran/service/word_iterator.dart';
import 'package:logging/logging.dart';

class LearningExperienceWizard {
  final log = Logger('LearningExperienceWizard');

  late WordIterator wordIterator;
  late List<Word> answerBankWords;

  late LearnExpWordIterator learnExpWordIterator;
  late LearnExpMCQIterator learnExpMCQIterator;

  Future<LearningExperienceWizard> initialize(Locale local) async {
    var wordRepo = WordRepo();
    List<Word> words = await wordRepo.getWordsToLearn(10);
    answerBankWords = await wordRepo.getWordsToLearn(30);
    wordIterator = WordIterator(words);

    _generateExperiences();
    return this;
  }

  List<Word> _getNextWords(int numberOfWords) {
    var words = <Word>[];
    for (var i = 0; i < numberOfWords; i++) {
      if (wordIterator.moveNext()) {
        words.add(wordIterator.current);
      }
    }
    return words;
  }

  List<Word> _generateExperiences() {
    var nextWords = _getNextWords(3);
    learnExpWordIterator = LearnExpWordIterator(nextWords);

    learnExpMCQIterator =
        LearnExpMCQIterator(words: nextWords, answerBankWords: answerBankWords);
    return nextWords;
  }

  bool hasNextExperience() =>
      learnExpWordIterator.moveNext() ||
      learnExpMCQIterator.moveNext() ||
      wordIterator.moveNext();

  Future<LearnExperience> getNextExperience() async {
    if (learnExpWordIterator.moveNext()) {
      return learnExpWordIterator.current;
    }
    if (learnExpMCQIterator.moveNext()) {
      return learnExpMCQIterator.current;
    }
    return getNextExperience();
  }
}

class LearnExperience {
  final Word word;

  LearnExperience({required this.word});
}
