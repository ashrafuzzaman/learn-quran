import 'package:flutter/material.dart';
import 'package:learnquran/dto/multi_Choice_question.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/random_mcq_generator.dart';

class LearningExperienceWizard implements Iterator<LearnExperience> {
  late LessonWordIterator wordIterator;

  late LearningExperienceWordIterator learningExperienceWordIterator;

  Future<LearningExperienceWizard> initialize(Locale local) async {
    var lessons = await WordLessonRepo().getLessons(local);
    wordIterator = LessonWordIterator(lessons);

    learningExperienceWordIterator =
        LearningExperienceWordIterator(lessons.first.words.take(3).toList());
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

class LessonWordIterator implements Iterator<Word> {
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
