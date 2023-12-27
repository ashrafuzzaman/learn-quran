import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:learnquran/dto/lesson.dart';
import 'package:learnquran/repository/word_lesson_file_repo.dart';

class LessonsCubit extends Cubit<List<LessonWithWords>> {
  LessonsCubit() : super([]) {
    initialize();
  }

  initialize() {
    var wordLessonRepo = WordLessonFileRepo();
    wordLessonRepo
        .getLessons(const Locale("en"))
        .then((lessons) => emit(lessons));
  }
}
