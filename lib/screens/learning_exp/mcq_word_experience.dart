import 'package:flutter/material.dart';
import 'package:learnquran/service/learn_exp_mcq.dart';
import 'package:learnquran/widgets/quiz/mcq_widget.dart';

class MCQWordExperienceWidget extends StatelessWidget {
  final MCQWordExperience experience;
  final Function onComplete;
  const MCQWordExperienceWidget(
      {super.key, required this.experience, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return MCQWidget(
      question: experience.getMCQ(),
      onComplete: (bool isCorrect) {
        onComplete();
      },
    );
  }
}
