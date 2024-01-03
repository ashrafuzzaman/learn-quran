import 'package:learnquran/dto/bookmark.dart';
import 'package:learnquran/dto/word.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/repository/repo_base.dart';
import 'package:logging/logging.dart';

const String tableBookmark = 'bookmark_words';
const String columnWordId = 'wordId';

class BookmarkRepo extends RepoBase {
  @override
  final log = Logger('BookmarkRepo');

  Future<List<Word>> getBookmarkedWords() async {
    var wordRepo = WordRepo();

    var result = await rawQuery('''
        SELECT w.*
        FROM words w
        INNER JOIN bookmark_words b ON w.id = b.wordId
        ORDER BY w.id DESC
      ''');
    return result.map((row) => wordRepo.recordToWord(row)).toList();
  }

  Future<bool> isMarked(int wordId) async {
    final result = await query(tableBookmark,
        columns: ['count(*) as total'],
        where: '$columnWordId=?',
        whereArgs: [wordId]);
    return result.first['total'] == 1;
  }

  Future<Bookmark> toggleMarked(int wordId) async {
    var marked = await isMarked(wordId);
    if (marked) {
      await unMark(wordId);
    } else {
      await mark(wordId);
    }
    marked = await isMarked(wordId);
    return Bookmark(wordId: wordId, isMarked: marked);
  }

  mark(int wordId) async {
    var marked = await isMarked(wordId);
    if (marked) {
      return;
    }
    await insert(tableBookmark, {
      columnWordId: wordId,
    });
  }

  unMark(int wordId) async {
    return await delete(tableBookmark,
        where: '$columnWordId = ?', whereArgs: [wordId]);
  }
}
