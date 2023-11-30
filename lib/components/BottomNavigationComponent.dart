import 'package:flutter/material.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    ]);
  }
}
