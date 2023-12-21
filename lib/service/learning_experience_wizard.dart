import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/random_mcq_generator.dart';
import 'package:learnquran/service/word_iterator.dart';

class LearningExperienceWizard implements Iterator<LearnExperience> {
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

  @override
  bool moveNext() =>
      learnExpWordIterator.moveNext() ||
      learnExpMCQIterator.moveNext() ||
      wordIterator.moveNext();
  @override
  LearnExperience get current => _getNextExperience();

  LearnExperience _getNextExperience() {
    if (learnExpWordIterator.moveNext()) {
      return learnExpWordIterator.current;
    }
    if (learnExpMCQIterator.moveNext()) {
      return learnExpMCQIterator.current;
    }
    _generateExperiences();
    return _getNextExperience();
  }
}

class LearnExpMCQIterator implements Iterator<LearnExperience> {
  final List<Word> _words;
  final List<Word> _answerBankWords;
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
    return MCQWordExperience(
        word: _words[_index++], answerBankWords: _answerBankWords);
  }
}

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

class LearnExperience {
  final Word word;

  LearnExperience({required this.word});
}

class LearnWordExperience extends LearnExperience {
  LearnWordExperience({required super.word});
}

class MCQWordExperience extends LearnExperience {
  List<Word> answerBankWords;
  MCQWordExperience({required super.word, required this.answerBankWords});

  getMCQ() {
    var questionGenerator = RandomMCQGenerator();
    return questionGenerator.getQuestion(
        word: word, answerBankWords: answerBankWords);
  }
}
