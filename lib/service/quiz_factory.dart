import 'dart:ui';

import 'package:learnquran/dto/quiz.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/repository/bookmark_repo.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';
import 'package:learnquran/service/random_mcq_generator.dart';

class QuizFactory {
  QuizFactory();

  Future<List<String>> _getBookmarkedWordIds() async {
    return await BookmarkRepo().getBookmarkedWordIds();
  }

  // _getMCQAttempts() async {
  //   List<WordAttempt> wordAttepmts =
  //       await MCQAttemptRepo().getWordAttemptsWithCount();
  //   return wordAttepmts;
  // }

  Future<Quiz> generateQuiz(Locale local, int totalQuestions) async {
    var wordLessonRepo = WordLessonRepo();
    List<WordLesson> lessons = await wordLessonRepo.getLessons(local);

    var questionGenerator = RandomMCQGenerator();
    var bookmarkedWordIds = await _getBookmarkedWordIds();

    List<Word> words = bookmarkedWordIds
        .map((wordId) => wordLessonRepo.getWordFromLesson(wordId, lessons))
        .toList();

    if (words.length < totalQuestions) {
      // Add more words if there is no bookmark
      words = [
        ...words,
        ...lessons.first.words.take(totalQuestions - words.length)
      ];
    }

    words.shuffle();
    var mcqList = words.map((word) =>
        questionGenerator.getQuestion(word: word, words: lessons[0].words));
    return Quiz(mcqList: mcqList);
  }
}
