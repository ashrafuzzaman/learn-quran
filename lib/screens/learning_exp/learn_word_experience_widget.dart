import 'package:flutter/material.dart';
import 'package:learnquran/service/learn_exp_word.dart';
import 'package:learnquran/widgets/word/word_flipcard.dart';

class LearnWordExperienceWidget extends StatelessWidget {
  LearnWordExperience experience;
  Function onComplete;
  LearnWordExperienceWidget(
      {super.key, required this.experience, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            WordFlipCardWidget(word: experience.word),
            ElevatedButton(
                onPressed: () => onComplete(), child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
