import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/random_mcq_generator.dart';

class LearningExperienceWizard implements Iterator<LearnExperience> {
  late WordIterator wordIterator;

  late LearningExperienceMCQIterator learningExperienceWordIterator;

  Future<LearningExperienceWizard> initialize(Locale local) async {
    var lessons = await WordLessonRepo().getLessons(local);
    wordIterator = WordIterator(lessons);
    var answerBankWords = lessons.first.words;

    learningExperienceWordIterator = LearningExperienceMCQIterator(
        words: answerBankWords.take(3).toList(),
        answerBankWords: answerBankWords);
    return this;
  }

  @override
  bool moveNext() => learningExperienceWordIterator.moveNext();
  @override
  LearnExperience get current => _getNextExperience();

  LearnExperience _getNextExperience() {
    return learningExperienceWordIterator.current;
  }
}

class LearningExperienceWordIterator implements Iterator<LearnExperience> {
  late List<Word> words;
  int _index = 0;

  LearningExperienceWordIterator(this.words);

  @override
  bool moveNext() => _index < words.length;

  @override
  LearnExperience get current => _getNextExperience();

  LearnExperience _getNextExperience() {
    return LearnWordExperience(word: words[_index++]);
  }
}

class LearningExperienceMCQIterator implements Iterator<LearnExperience> {
  final List<Word> _words;
  final List<Word> _answerBankWords;
  int _index = 0;

  LearningExperienceMCQIterator(
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

class WordIterator implements Iterator<Word> {
  final List<Word> _words = [];

  WordIterator(List<WordLesson> lessons) {
    for (var lesson in lessons) {
      _words.addAll(lesson.words);
    }
  }

  var _index = 0;
  @override
  Word get current => _words[_index++];
  @override
  bool moveNext() => _index < _words.length;
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
