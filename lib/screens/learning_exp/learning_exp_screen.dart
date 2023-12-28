import 'package:flutter/material.dart';
import 'package:learnquran/screens/learning_exp/mcq_word_experience.dart';
import 'package:learnquran/screens/learning_exp/learn_word_experience_widget.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/service/learn_exp_word.dart';
import 'package:learnquran/service/learning_experience_wizard.dart';

class LearningExpScreen extends StatefulWidget {
  const LearningExpScreen({super.key});

  @override
  State<LearningExpScreen> createState() => _LearningExpScreenState();
}

class _LearningExpScreenState extends State<LearningExpScreen> {
  final PageController controller = PageController(initialPage: 0);
  late LearningExperienceWizard wizard = LearningExperienceWizard();

  navigateToNextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<Widget> createExperience() async {
    LearnExperience? exp = await wizard.getNextExperience();

    switch (exp.runtimeType) {
      case const (LearnWordExperience):
        return LearnWordExperienceWidget(
          experience: (exp as LearnWordExperience),
          onComplete: () => navigateToNextPage(),
        );
      case const (MCQWordExperience):
        return MCQWordExperienceWidget(
          experience: (exp as MCQWordExperience),
          onComplete: () => navigateToNextPage(),
        );
    }
    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LearningExperienceWizard>(
        future: wizard.initialize(),
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
                itemBuilder: (context, position) {
                  if (!wizard.hasNextExperience()) return null;
                  return FutureBuilder<Widget>(
                    future: createExperience(),
                    builder: (context, AsyncSnapshot<Widget> expSnapshot) {
                      if (expSnapshot.data != null) {
                        return expSnapshot.data!;
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
