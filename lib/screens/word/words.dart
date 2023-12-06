import 'package:flutter/material.dart';
import 'package:learnquran/widgets/word_list_widget.dart';
import 'package:learnquran/widgets/word_pageview_widget.dart';
import 'package:learnquran/dto/word.dart';

class WordListPage extends StatefulWidget {
  final List<Word> words;

  const WordListPage(this.words, {super.key});

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  static const int listViewIndex = 0;
  static const int flipCardViewIndex = 1;
  int _selectedIndex = listViewIndex;
  int _selectedWordIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isListView() {
    return _selectedIndex == listViewIndex;
  }

  void _switchToFlipCardView(int wordId) {
    final wordIndex = widget.words.indexWhere((word) => word.id == wordId);
    setState(() {
      _selectedIndex = flipCardViewIndex;
      _selectedWordIndex = wordIndex;
    });
  }

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
      body: _isListView()
          ? WordListWidget(widget.words, (int wordId) {
              _switchToFlipCardView(wordId);
            })
          : WordPageviewWidget(widget.words, _selectedWordIndex),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.list),
              label: "List View",
            ),
            NavigationDestination(
              icon: Icon(Icons.view_carousel),
              label: "Flipcard view",
            ),
          ]),
    );
  }
}
