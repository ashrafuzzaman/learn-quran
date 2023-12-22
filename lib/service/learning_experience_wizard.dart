import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/progression_repo.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/service/learn_exp_word.dart';
import 'package:learnquran/service/word_iterator.dart';

class LearningExperienceWizard {
  late WordIterator wordIterator;
  late List<Word> answerBankWords;

  late LearnExpMCQIterator learnExpMCQIterator;
  late LearnExpWordIterator learnExpWordIterator;

  Future<LearningExperienceWizard> initialize(Locale local) async {
    var latestReadWordId = await ProgressionRepo().getLatestReadWordId();
    var lessons = await WordLessonRepo().getLessons(local);
    wordIterator = WordIterator(lessons, latestReadWordId);
    answerBankWords = List<Word>.of(wordIterator.words);

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

    var isAllCorrect =
        learnExpMCQIterator.mcqWordExperiences.every((mcq) => mcq.isCorrect!);
    var nextWords = _generateExperiences();
    if (isAllCorrect) {
      ProgressionRepo().recordProgression(nextWords.first.id);
    }
    return getNextExperience();
  }
}

class LearnExperience {
  final Word word;

  LearnExperience({required this.word});
}
