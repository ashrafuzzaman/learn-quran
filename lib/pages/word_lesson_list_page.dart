import 'package:flutter/material.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/pages/word_list_page.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';

class WordLessonListPage extends StatelessWidget {
  const WordLessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wordLessonRepo = WordLessonRepo();

    return FutureBuilder(
        future: wordLessonRepo.getLessons(),
        builder: (context, AsyncSnapshot<List<WordLesson>> snapshot) {
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
            // bottomNavigationBar: const BottomNavigationComponent(),
          );
        });
  }
}

class WordListWidget extends StatelessWidget {
  final AsyncSnapshot<List<WordLesson>> lessons;

  const WordListWidget(this.lessons, {super.key});

  @override
  Widget build(BuildContext context) {
    if (!lessons.hasData) {
      return const CircularProgressIndicator();
    }

    return ListView(
        children: lessons.data!
            .map((lesson) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        lesson.name,
                        style: const TextStyle(fontSize: 32),
                      ),
                      subtitle: Text(
                        lesson.description,
                        style: const TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return WordListPage(lesson.words);
                          }),
                        );
                      },
                    ),
                  ),
                ))
            .toList());
  }
}
