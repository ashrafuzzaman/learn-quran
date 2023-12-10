import 'package:flutter/material.dart';
import 'package:learnquran/screens/settings.dart';
import 'package:learnquran/screens/word/lessons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle = const TextStyle(fontSize: 22);

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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 36),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            icon: const Icon(Icons.chrome_reader_mode),
            label: Text(
              'Learn words',
              style: buttonTextStyle,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WordLessonListPage()),
              );
            },
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 36),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            icon: const Icon(Icons.settings),
            label: Text('Settings', style: buttonTextStyle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      )),
    );
  }
}
