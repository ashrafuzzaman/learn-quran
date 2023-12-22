import 'package:flutter/material.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/widgets/quiz/mcq_widget.dart';

class MCQWordExperienceWidget extends StatelessWidget {
  MCQWordExperience experience;
  Function onComplete;
  MCQWordExperienceWidget(
      {super.key, required this.experience, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return MCQWidget(
      question: experience.getMCQ(),
      showNext: true,
      onComplete: (bool isCorrect) {
        experience.recordAttempt(isCorrect).then((_) {
          onComplete();
        });
      },
    );
  }
}
