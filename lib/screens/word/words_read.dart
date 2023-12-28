import 'package:flutter/material.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/screens/word/words.dart';

class WordsReadPage extends StatelessWidget {
  const WordsReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wordLessonRepo = WordRepo();

    return FutureBuilder(
        future: wordLessonRepo.getWordsRead(),
        builder: (context, AsyncSnapshot<List<Word>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Word> words = snapshot.data!;
          return WordListPage(
              title: "Words read",
              emptyTitle: "Start learning words",
              words: words);
        });
  }
}
