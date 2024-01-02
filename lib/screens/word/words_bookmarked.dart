import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/bookmark_repo.dart';
import 'package:learnquran/screens/word/words.dart';

class WordsBookmarkedPage extends StatelessWidget {
  const WordsBookmarkedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bookmarkRepo = BookmarkRepo();

    return FutureBuilder(
        future: bookmarkRepo.getBookmarkedWords(),
        builder: (context, AsyncSnapshot<List<Word>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Word> words = snapshot.data!;
          return WordListPage(
              title: "Words read",
              emptyTitle: "Start Bookmarking words",
              mainTab: const Tab(
                icon: FaIcon(FontAwesomeIcons.bookmark),
                text: "Bookmarked",
              ),
              words: words);
        });
  }
}
