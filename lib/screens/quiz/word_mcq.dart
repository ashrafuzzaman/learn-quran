import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/lessons_cubit.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/service/random_mcq_generator.dart';
import 'package:learnquran/widgets/quiz/mcq_widget.dart';

class WordMCQ extends StatelessWidget {
  final Word word;
  const WordMCQ({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsCubit, List<WordLesson>>(
        builder: (context, lessons) {
      var questionGenerator = RandomMCQGenerator();
      var question = questionGenerator.getQuestion(
          word: word, answerBankWords: lessons[0].words);

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
            child: MCQWidget(
          question: question,
          onComplete: (isCorrect) => {},
        )),
      );
    });
  }
}
