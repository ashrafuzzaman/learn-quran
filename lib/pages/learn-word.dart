import 'package:flutter/material.dart';
import 'package:learnquran/components/BottomNavigationComponent.dart';

class LearnWordPage extends StatelessWidget {
  const LearnWordPage(element, {super.key});

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
      body: ListView(children: const <Widget>[
        ListTile(
          leading: Icon(Icons.bar_chart_rounded),
          title: Text('Learn words'),
        ),
      ]),
      bottomNavigationBar: const BottomNavigationComponent(),
    );
  }
}
