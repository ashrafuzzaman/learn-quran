import 'package:flutter/material.dart';

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

  static const unselectedIconColor =
      Color(0xFF757575); // Equivalent to Colors.grey[600]

  @override
  Widget build(BuildContext context) {
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: unselectedIconColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb, color: unselectedIconColor),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, color: unselectedIconColor),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: unselectedIconColor),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, color: unselectedIconColor),
            label: 'Explore',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
