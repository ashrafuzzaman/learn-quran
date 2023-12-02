import 'package:flutter/material.dart';
import 'package:learnquran/components/WordListBottomNavigationComponent.dart';
import 'package:learnquran/dto/word.dart';

class WordListPage extends StatelessWidget {
  final List<Word> words;

  const WordListPage(this.words, {super.key});

  @override
  Widget build(BuildContext context) {
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
      body: WordListWidget(words),
      bottomNavigationBar: const WordListBottomNavigationComponent(),
    );
  }
}

class WordListWidget extends StatelessWidget {
  final List<Word> words;

  const WordListWidget(this.words, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: words
            .map((word) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        word.arabic,
                        style: const TextStyle(fontSize: 48),
                      ),
                      subtitle: Text(
                        word.meaning,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}
