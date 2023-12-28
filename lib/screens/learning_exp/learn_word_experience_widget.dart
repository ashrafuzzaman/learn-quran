import 'package:flutter/material.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/service/learn_exp_word.dart';
import 'package:learnquran/widgets/word/word_flipcard.dart';

class LearnWordExperienceWidget extends StatelessWidget {
  final LearnWordExperience experience;
  final Function onComplete;
  const LearnWordExperienceWidget(
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
                onPressed: () {
                  WordRepo()
                      .markRead(experience.word.id!)
                      .then((_) => onComplete());
                },
                child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
