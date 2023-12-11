import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/lessons_cubit.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/service/random_multi_choice_quiz_generator.dart';
import 'package:learnquran/widgets/quiz/multi_choice.dart';

class AllWordsQuiz extends StatefulWidget {
  const AllWordsQuiz({super.key});

  @override
  State<AllWordsQuiz> createState() => _AllWordsQuizState();
}

class _AllWordsQuizState extends State<AllWordsQuiz> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return BlocBuilder<LessonsCubit, List<WordLesson>>(
        builder: (context, lessons) {
      final List<Word> words =
          lessons.isNotEmpty ? List.from(lessons[0].words) : [];
      var quizGenerator = RandomMultiChoiceQuizGenerator();
      words.shuffle();

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
        body: PageView(
          controller: controller,
          children: words
              .map(
                (word) => Center(
                    child: MultiChoiceQuizWidget(
                        quiz: quizGenerator.getQuiz(word: word, words: words))),
              )
              .toList(),
        ),
      );
    });
  }
}
