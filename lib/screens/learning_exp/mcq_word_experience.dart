import 'package:flutter/material.dart';
import 'package:learnquran/repository/mcq_attempt_repo.dart';
import 'package:learnquran/service/learning_experience_wizard.dart';
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
