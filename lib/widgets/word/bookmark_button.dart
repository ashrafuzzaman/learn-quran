import 'package:flutter/material.dart';
import 'package:learnquran/repository/bookmark_repo.dart';
import 'package:learnquran/screens/word/word_details.dart';
import 'package:learnquran/widgets/word/word_icon.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/theme/theme_helper.dart';


class BookmarkButton extends StatefulWidget {
  const BookmarkButton({
    super.key,
    required this.wordId,
  });

  final int wordId;

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool isMarked = false;

  @override
  initState() {
    super.initState();

    BookmarkRepo().isMarked(widget.wordId).then((marked) => setState(() {
          isMarked = marked;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: isMarked
          ? const Icon(Icons.bookmark)
          : const Icon(Icons.bookmark_add_outlined),
      onPressed: () async {
        var bookmark = await BookmarkRepo().toggleMarked(widget.wordId);
        setState(() {
          isMarked = bookmark.isMarked;
        });
      },
    );
  }
}

class FlipCardMeaning extends StatelessWidget {
  const FlipCardMeaning({
    super.key,
    required this.word,
  });

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
          color: getWordBackgroundColor(context, word),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 48,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'meaning:${word.id}',
                      child: Text(
                        word.meaning,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      word.totalExamples == 0
                          ? const SizedBox.shrink()
                          : TextButton(
                              child: const Text("Examples"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WordDetails(word: word)),
                                );
                              },
                            ),
                      WordIcon(word: word),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
