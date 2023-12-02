import 'package:flutter/material.dart';

class WordListBottomNavigationComponent extends StatelessWidget {
  const WordListBottomNavigationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.list), label: "List View"),
      BottomNavigationBarItem(icon: Icon(Icons.view_carousel), label: "Word view"),
    ]);
  }
}
