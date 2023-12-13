import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/lessons_cubit.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/service/random_multi_choice_quiz_generator.dart';
import 'package:learnquran/widgets/quiz/multi_choice.dart';

class WordQuiz extends StatelessWidget {
  final Word word;
  const WordQuiz({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsCubit, List<WordLesson>>(
        builder: (context, lessons) {
      var quizGenerator = RandomMultiChoiceQuizGenerator();
      var quiz = quizGenerator.getQuiz(word: word, words: lessons[0].words);

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quiz',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 3,
        ),
        body: Center(
            child: MultiChoiceQuizWidget(
          quiz: quiz,
          onComplete: () => {},
        )),
      );
    });
  }
}
