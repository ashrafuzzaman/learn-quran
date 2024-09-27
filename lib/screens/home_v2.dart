import 'package:flutter/material.dart';
import 'package:learnquran/screens/learning_exp/learning_exp_screen.dart';
import 'package:learnquran/screens/lesson/lesson_list_screen.dart';
import 'package:learnquran/screens/quiz/all_words_quiz.dart';
import 'package:learnquran/screens/settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquran/screens/word/words_bookmarked.dart';
import 'package:learnquran/screens/word/words_read.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var defaultIconColor = Colors.grey[600];
    return Scaffold(
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 50),
        child: Column(
          children: [
            Heading(),
          ],
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: defaultIconColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb, color: defaultIconColor),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, color: defaultIconColor),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: defaultIconColor),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, color: defaultIconColor),
            label: 'Explore',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[500],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Salam,',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          Icon(Icons.settings)
        ],
      ),
    );
  }
}
