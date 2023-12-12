import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnquran/cubit/lessons_cubit.dart';
import 'package:learnquran/dto/word_lesson.dart';
import 'package:learnquran/screens/word/words.dart';
import 'package:learnquran/repository/word_lesson_repo.dart';

class WordLessonListPage extends StatelessWidget {
  const WordLessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wordLessonRepo = WordLessonRepo();

    return FutureBuilder(
        future: wordLessonRepo.getLessons(const Locale("en")),
        builder: (context, AsyncSnapshot<List<WordLesson>> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Learn Quranic words',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 3,
            ),
            body: const WordListWidget(),
          );
        });
  }
}

class WordListWidget extends StatelessWidget {
  const WordListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsCubit, List<WordLesson>>(
      builder: (context, lessons) {
        if (lessons.isEmpty) {
          return const CircularProgressIndicator();
        }

        return ListView(
            children: lessons
                .map((lesson) => Padding(
                      padding: const EdgeInsets.all(20),
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
                                return WordListPage(
                                    title: lesson.name, words: lesson.words);
                              }),
                            );
                          },
                        ),
                      ),
                    ))
                .toList());
      },
    );
  }
}
