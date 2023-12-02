import 'package:flutter/material.dart';
import 'package:learnquran/pages/word_lesson_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn Quran',
          style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: ListView(children: <Widget>[
        ListTile(
          leading: const Icon(Icons.bar_chart_rounded),
          title: const Text('Learn words'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WordLessonListPage()),
            );
          },
        ),
        const ListTile(
          leading: Icon(Icons.auto_stories),
          title: Text('Learn Grammer'),
        ),
      ]),
    );
  }
}
