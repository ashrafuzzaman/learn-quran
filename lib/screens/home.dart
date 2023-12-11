import 'package:flutter/material.dart';
import 'package:learnquran/screens/quiz/all_words_quiz.dart';
import 'package:learnquran/screens/settings.dart';
import 'package:learnquran/screens/word/lessons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn Quranic words',
          style: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomePageButton(
            widget: WordLessonListPage(),
            label: 'Learn words',
            icon: Icons.chrome_reader_mode,
          ),
          HomePageButton(
            widget: AllWordsQuiz(),
            label: 'Quiz',
            icon: Icons.quiz,
          ),
          HomePageButton(
            widget: SettingsPage(),
            label: 'Settings',
            icon: Icons.settings,
          ),
        ],
      )),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    super.key,
    required this.widget,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle = const TextStyle(fontSize: 22);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 36),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        label,
        style: buttonTextStyle,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
    );
  }
}
