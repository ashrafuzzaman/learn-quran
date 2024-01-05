import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquran/dto/lesson.dart';
import 'package:learnquran/repository/lesson_repo.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var lessonRepo = LessonRepo();
    return FutureBuilder(
        future: lessonRepo.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var lessons = snapshot.data as List<Lesson>;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lessons'),
            ),
            body: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                var lesson = lessons[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          Text(lesson.name,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text(
                              "Learned ${lesson.wordsLearned.toString()}/${lesson.totalWords.toString()}"),
                          CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 10.0,
                            percent: lesson.wordsLearned / lesson.totalWords,
                            center: const FaIcon(FontAwesomeIcons.book),
                            progressColor: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
