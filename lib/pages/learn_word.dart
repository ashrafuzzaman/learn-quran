import 'package:flutter/material.dart';
import 'package:learnquran/components/BottomNavigationComponent.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/providers/words_provider.dart';

class LearnWordPage extends StatelessWidget {
  const LearnWordPage({super.key});

  // final Future<List<Word>> _words = wordsProvider();

  @override
  Widget build(BuildContext context) {
    var words = wordsProvider();

    return FutureBuilder(
        future: words,
        builder: (context, AsyncSnapshot<List<Word>> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Learn Quranic words',
                style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 3,
            ),
            body: WordListWidget(snapshot),
            bottomNavigationBar: const BottomNavigationComponent(),
          );
        });
  }
}

class WordListWidget extends StatelessWidget {
  final AsyncSnapshot<List<Word>> wordList;

  const WordListWidget(this.wordList, {super.key});

  @override
  Widget build(BuildContext context) {
    if (!wordList.hasData) {
      return const CircularProgressIndicator();
    }

    return ListView(
        children: wordList.data!
            .map((word) => ListTile(
                  title: Text(
                    word.arabic,
                    style: TextStyle(fontSize: 48),
                  ),
                ))
            .toList());
  }
}
