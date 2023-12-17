import 'dart:ui';

import 'package:learnquran/dto/quiz.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/repository/bookmark_repo.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/random_mcq_generator.dart';

class QuizFactory {
  QuizFactory();

  Future<Quiz> generateQuiz(Locale local) async {
    var wordLessonRepo = WordLessonRepo();
    List<WordLesson> lessons = await wordLessonRepo.getLessons(local);

    var questionGenerator = RandomMCQGenerator();
    var wordIds = await BookmarkRepo().getBookmarkedWordIds();

    var words = wordIds
        .map((wordId) => wordLessonRepo.getWordFromLesson(wordId, lessons))
        .toList();

    if (words.length < 2) {
      // Add more words if there is no bookmark
      words = [...words, ...lessons.first.words.take(10)];
    }

    words.shuffle();
    var mcqList = words.map((word) =>
        questionGenerator.getQuestion(word: word!, words: lessons[0].words));
    return Quiz(mcqList: mcqList);
  }
}
