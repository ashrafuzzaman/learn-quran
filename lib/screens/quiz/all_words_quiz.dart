import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/widgets/quiz/mcq_widget.dart';

class AllWordsQuiz extends StatefulWidget {
  const AllWordsQuiz({super.key});

  @override
  State<AllWordsQuiz> createState() => _AllWordsQuizState();
}

class _AllWordsQuizState extends State<AllWordsQuiz> {
  final PageController controller = PageController(initialPage: 0);

  Future<LearnExpMCQIterator> getMCQExpIterator() async {
    var wordsRepo = WordRepo();
    List<Word> words = await wordsRepo.getWordsToLearn(15);
    List<Word> answerBankWords = await wordsRepo.getAllWords(40);

    return LearnExpMCQIterator(words: words, answerBankWords: answerBankWords);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LearnExpMCQIterator>(
        future: getMCQExpIterator(),
        builder: (context, AsyncSnapshot<LearnExpMCQIterator> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
            body: PageView.builder(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                var learnExpMCQIterator = snapshot.data!;
                if (!learnExpMCQIterator.moveNext()) return null;
                MCQWordExperience exp = learnExpMCQIterator.current;
                return Center(
                    child: MCQWidget(
                  question: exp.getMCQ(),
                  onComplete: (bool isCorrect) {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ));
              },
            ),
          );
        });
  }
}
