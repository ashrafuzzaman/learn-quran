import 'package:flutter/material.dart';
import 'package:learnquran/dto/multi_Choice_question.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/random_mcq_generator.dart';

class LearningExperienceWizard {
  late List<Word> allWords;
  late Word _currentWord;
  bool _quizeMode = false;
  int index = 0;
  final List<Word> _wordsRead = [];
  late LessonWordIterator wordIterator;

  Future<LearningExperienceWizard> initialize(Locale local) async {
    var lessons = await WordLessonRepo().getLessons(local);
    wordIterator = LessonWordIterator(lessons);
    allWords = lessons.first.words;
    _currentWord = allWords.first;
    return this;
  }

  LearnExperience? getCurrentExperience() {
    if (index > 10) {
      return null;
    }

    if (_quizeMode) {
      var mcqWordExperience = MCQWordExperience(word: _currentWord);
      mcqWordExperience.initialize(allWords);
      return mcqWordExperience;
    } else {
      return LearnWordExperience(word: _currentWord);
    }
  }

  moveNext() {
    index++;
    if (_wordsRead.length % 3 == 0) {
      _quizeMode = true;
    } else {
      _selectNextWord();
    }
  }

  _selectNextWord() {
    _wordsRead.add(_currentWord);
    _currentWord = wordIterator.current;
  }
}

class LessonWordIterator implements Iterator {
  final List<Word> _words = [];

  LessonWordIterator(List<WordLesson> lessons) {
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
  late MultiChoiceQuestion mcq;
  MCQWordExperience({required super.word});

  initialize(List<Word> words) {
    var questionGenerator = RandomMCQGenerator();
    mcq = questionGenerator.getQuestion(word: word, words: words);
  }
}
