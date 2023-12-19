import 'package:flutter/material.dart';
import 'package:learnquran/service/learning_experience.dart';
import 'package:learnquran/widgets/quiz/mcq_widget.dart';
import 'package:learnquran/widgets/word/word_flipcard.dart';

class LearningExpPage extends StatefulWidget {
  const LearningExpPage({super.key});

  @override
  State<LearningExpPage> createState() => _LearningExpPageState();
}

class _LearningExpPageState extends State<LearningExpPage> {
  final PageController controller = PageController(initialPage: 0);
  int currentPageIndex = 0;
  int pageCount = 10;
  late LearnExperience currentExperience;
  late LearningExperienceWizard wizard = LearningExperienceWizard();

  addPageView() {
    setState(() {
      pageCount++;
    });
  }

  navigateToNextPage() {
    wizard.moveNext();
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  getCurrentPage(int page) {
    setState(() {
      currentPageIndex = page;
    });
  }

  createPage() {
    LearnExperience? exp = wizard.getCurrentExperience();

    switch (exp.runtimeType) {
      case const (Null):
        return null;
      case const (LearnWordExperience):
        return Center(
          child: SizedBox(
            height: 300,
            child: Column(
              children: [
                WordFlipCardWidget(word: exp!.word),
                ElevatedButton(
                    onPressed: () => navigateToNextPage(),
                    child: const Text('Next'))
              ],
            ),
          ),
        );
      case const (MCQWordExperience):
        return MCQWidget(
          question: (exp as MCQWordExperience).mcq,
          showNext: true,
          onComplete: (bool isCorrect) {
            // quiz!.recordAttempt(isCorrect);
            navigateToNextPage();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LearningExperienceWizard>(
        future: wizard.initialize(const Locale("en")),
        builder: (context, AsyncSnapshot<LearningExperienceWizard> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Learning Session',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                elevation: 2,
              ),
              body: PageView.builder(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: getCurrentPage,
                itemCount: pageCount,
                itemBuilder: (context, position) {
                  return createPage();
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
