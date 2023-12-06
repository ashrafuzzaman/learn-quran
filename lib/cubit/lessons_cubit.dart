import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';

class LessonsCubit extends Cubit<List<WordLesson>> {
  LessonsCubit() : super([]) {
    initialize();
  }

  initialize() {
    var wordLessonRepo = WordLessonRepo();
    wordLessonRepo
        .getLessons(const Locale("en"))
        .then((lessons) => emit(lessons));
  }
}
