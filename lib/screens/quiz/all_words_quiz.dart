import 'package:flutter/material.dart';
import 'package:learnquran/dto/quiz.dart';
import 'package:learnquran/service/quiz_factory.dart';
import 'package:learnquran/widgets/quiz/mcq_widget.dart';

class AllWordsQuiz extends StatefulWidget {
  const AllWordsQuiz({super.key});

  @override
  State<AllWordsQuiz> createState() => _AllWordsQuizState();
}

class _AllWordsQuizState extends State<AllWordsQuiz> {
  final PageController controller = PageController(initialPage: 0);
  Quiz? quiz;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    QuizFactory()
        .generateRandomQuiz(const Locale("en"), 10)
        .then((generatedQuiz) {
      setState(() {
        quiz = generatedQuiz;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quiz == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: quiz!.mcqList
            .map(
              (mcq) => Center(
                  child: MCQWidget(
                question: mcq,
                showNext: true,
                onComplete: (bool isCorrect) {
                  quiz!.recordAttempt(isCorrect);
                  controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
              )),
            )
            .toList(),
      ),
    );
  }
}
