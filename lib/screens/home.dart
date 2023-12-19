import 'package:flutter/material.dart';
import 'package:learnquran/screens/learning_exp/learning_exp_page.dart';
import 'package:learnquran/screens/quiz/all_words_quiz.dart';
import 'package:learnquran/screens/settings.dart';
import 'package:learnquran/screens/word/lessons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var titleTextColor = Theme.of(context).colorScheme.surface;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 250,
        backgroundColor: Theme.of(context).colorScheme.shadow,
        title: Center(
          child: Column(
            children: [
              Text(
                'Road to understanding',
                style: TextStyle(fontSize: 32, color: titleTextColor),
              ),
              Text(
                '85%',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: titleTextColor),
              ),
              Text(
                'of The Quran',
                style: TextStyle(fontSize: 32, color: titleTextColor),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomePageButton(
            widget: LearningExpPage(),
            // widget: WordLessonListPage(),
            label: 'Learn words',
            icon: FaIcon(FontAwesomeIcons.graduationCap),
          ),
          SizedBox(
            height: 16,
          ),
          HomePageButton(
            widget: AllWordsQuiz(),
            label: 'Quiz',
            icon: FaIcon(FontAwesomeIcons.chartSimple),
          ),
          SizedBox(
            height: 16,
          ),
          HomePageButton(
            widget: SettingsPage(),
            label: 'Settings',
            icon: FaIcon(FontAwesomeIcons.gear),
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
  final FaIcon icon;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle = const TextStyle(fontSize: 22);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      icon: icon,
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
