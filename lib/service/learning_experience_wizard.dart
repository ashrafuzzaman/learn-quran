import 'package:flutter/material.dart';
import 'package:learnquran/dto/multi_Choice_question.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/mcq_attempt_repo.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/learn_exp_mcq_iterator.dart';
import 'package:learnquran/service/learn_exp_word_iterator.dart';
import 'package:learnquran/service/random_mcq_generator.dart';
import 'package:learnquran/service/word_iterator.dart';

class LearningExperienceWizard {
  late WordIterator wordIterator;
  late List<Word> answerBankWords;

  late LearnExpMCQIterator learnExpMCQIterator;
  late LearnExpWordIterator learnExpWordIterator;

  Future<LearningExperienceWizard> initialize(Locale local) async {
    var lessons = await WordLessonRepo().getLessons(local);
    wordIterator = WordIterator(lessons);
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

  void _generateExperiences() {
    var nextWords = _getNextWords(3);
    learnExpWordIterator = LearnExpWordIterator(nextWords);

    learnExpMCQIterator =
        LearnExpMCQIterator(words: nextWords, answerBankWords: answerBankWords);
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
    } else {
      learnExpMCQIterator.mcqWordExperiences.forEach((mcqWordExperience) {
        print(
            "${mcqWordExperience.word.arabic}: ${mcqWordExperience.isCorrect}");
      });
    }
    _generateExperiences();
    return getNextExperience();
  }
}

class LearnExperience {
  final Word word;

  LearnExperience({required this.word});
}

class LearnWordExperience extends LearnExperience {
  LearnWordExperience({required super.word});
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
    await MCQAttemptRepo().recordAttempt(word.id, isCorrect);
    this.isCorrect = isCorrect;
  }
}
